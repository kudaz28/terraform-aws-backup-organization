provider "aws" {
  alias   = "management"
  region  = "eu-west-2"  # or your desired region
  profile = "management" # optional if you use named AWS CLI profiles
}

provider "aws" {
  alias   = "delegate_backup_account"
  region  = "eu-west-2"               # or your desired region
  profile = "delegate_backup_account" # optional if you use named AWS CLI profiles
}

