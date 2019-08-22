provider "aws" {
  region = "${var.aws-region}"
  profile = "${var.profile}"
  shared_credentials_file = "${var.shared_credentials_file}"
}
