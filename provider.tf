# terraform {
#   backend "s3" {
#     bucket = "tf3469"
#     key    = "tffile.tfstate"
#     region = "us-east-2"
#     encrypt = true
#   }
# }

provider "aws" {
  region = "us-east-2"
  # Optional: Set the AWS access and secret keys here, or use other authentication methods.
  access_key = "AKIAXR4IZSQJOGQUEBN3"
  secret_key = "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"
}
# provider "azurerm" {
#   features {}

#   client_id       = "6ef47003-0ac2-4286-bdf6-4f20078a8bf0"
#   client_secret   = "LfB8Q~Dgyei-L_mEjG2CIbmXzssmR1HbOFynQcgp"
#   tenant_id       = "0d7cc8e9-be54-45cc-b2e3-041a9b45aa57"
#   subscription_id = "b2aec48f-6dad-4d57-ad25-dad521fe74a4"
# }

#neew hangees in rhe provider file

##secind line added
