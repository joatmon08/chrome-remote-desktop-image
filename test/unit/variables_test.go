package unit

import (
	"os"
	"testing"
)

var packerVariables = []string{
	"TF_VAR_crd_user",
	"GOOGLE_COMPUTE_ZONE",
	"GOOGLE_APPLICATION_CREDENTIALS",
	"COMMIT_HASH",
}

func TestPackerVariablesSet(t *testing.T) {
	for _, variable := range packerVariables {
		if _, ok := os.LookupEnv(variable); !ok {
			t.Errorf("%s is undefined", variable)
		}
	}
}

func TestGoogleCredentials(t *testing.T) {
	filename, ok := os.LookupEnv("GOOGLE_APPLICATION_CREDENTIALS")
	if !ok {
		t.Errorf("%s is undefined", "GOOGLE_APPLICATION_CREDENTIALS")
	}
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		t.Errorf("%s does not exist", filename)
	}
	if info.Size() == 0 {
		t.Errorf("%s does not have content", filename)
	}
}
