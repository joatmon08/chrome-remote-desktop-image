package unit

import (
	"os"
	"testing"
)

var packerVariables = []string{
	"TF_VAR_crd_user",
	"GCLOUD_ZONE",
	"COMMIT_HASH",
}

func TestPackerVariablesSet(t *testing.T) {
	for _, variable := range packerVariables {
		if _, ok := os.LookupEnv(variable); !ok {
			t.Errorf("%s is undefined", variable)
		}
	}
}
