data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tf-test-bucket-state-2026-02-10"
    key = "network/dev/terraform.tfstate"
    region = "eu-central-1"
    profile = "vegait"
  }
}