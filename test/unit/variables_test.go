package unit

import (
	"os"
	"testing"
)

var packerVariables = []string{
	"TF_VAR_crd_user",
	"GOOGLE_COMPUTE_ZONE",
	"GOOGLE_APPLICATION_CREDENTIALS",
	"GOOGLE_PROJECT",
	"COMMIT_HASH",
}

func TestPackerVariablesSet(t *testing.T) {
	for _, variable := range packerVariables {
		if _, ok := os.LookupEnv(variable); !ok {
			t.Errorf("%s is undefined", variable)
		}
	}
}

func TestCommitHash(t *testing.T) {
	value, ok := os.LookupEnv("COMMIT_HASH")
	if !ok {
		t.Errorf("%s is undefined", "COMMIT_HASH")
	}
	if len(value) != 7 {
		t.Errorf("%s was not truncated correctly", value)
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
