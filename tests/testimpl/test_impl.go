package testimpl

import (
	"context"
	"net/url"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/messaging/azservicebus/admin"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	// The client requires the full hostname of the service bus
	busEndpoint := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_endpoint")
	u, err := url.Parse(busEndpoint)
	if err != nil {
		t.Fatalf("Unable to parse service bus endpoint: %e\n", err)
	}
	busName := u.Hostname()

	adminClient, err := admin.NewClient(busName, credential, nil)
	if err != nil {
		t.Fatalf("Unable to create service bus admin client: %e\n", err)
	}

	t.Run("DoesNamespaceExist", func(t *testing.T) {
		resp, err := adminClient.GetNamespaceProperties(context.TODO(), nil)
		if err != nil {
			t.Fatalf("Unable to get namespace properties: %e\n", err)
		}
		name := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_name")

		assert.Equal(t, name, resp.Name, "Expected name to be %s, got %s", name, resp.Name)
	})

	t.Run("IsNamespaceOutputCorrect", func(t *testing.T) {
		primaryConnectionString := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_default_primary_connection_string")
		assert.NotEmpty(t, primaryConnectionString, "Expected primary connection string to be non-empty")
		assert.Contains(t, primaryConnectionString, "Endpoint=sb://", "Expected primary connection string to contain 'Endpoint=sb://")
		secondaryConnectionString := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_default_secondary_connection_string")
		assert.NotEmpty(t, secondaryConnectionString, "Expected secondary connection string to be non-empty")
		assert.Contains(t, secondaryConnectionString, "Endpoint=sb://", "Expected secondary connection string to contain 'Endpoint=sb://")
		primaryKey := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_default_primary_key")
		assert.NotEmpty(t, primaryKey, "Expected primary key to be non-empty")
		secondaryKey := terraform.Output(t, ctx.TerratestTerraformOptions(), "namespace_default_secondary_key")
		assert.NotEmpty(t, secondaryKey, "Expected secondary key to be non-empty")
	})

	t.Run("DoTopicsExist", func(t *testing.T) {
		topic1Name := terraform.Output(t, ctx.TerratestTerraformOptions(), "topic1_name")
		topic2Name := terraform.Output(t, ctx.TerratestTerraformOptions(), "topic2_name")
		for _, topicName := range []string{topic1Name, topic2Name} {
			resp, err := adminClient.GetTopic(context.TODO(), topicName, nil)
			if err != nil {
				t.Fatalf("Unable to retrieve topic: %e\n", err)
			}

			assert.Equal(t, topicName, resp.TopicName, "Expected topic name to be %s, got %s", topicName, resp.TopicName)
			assert.Equal(t, "Active", string(*resp.Status), "Expected topic status to be Active, got %s", string(*resp.Status))
		}
	})
}
