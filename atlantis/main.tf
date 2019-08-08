provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 2.0"

  name = "atlantis"

  cidr            = "10.20.0.0/16"
  azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]

  atlantis_image = ""

  route53_zone_name = ""

  policies_arn = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

  atlantis_github_user       = ""
  atlantis_github_user_token = ""
  atlantis_repo_whitelist    = ["github.com/username/*"]

  custom_environment_variables = [
    {
      name  = "ATLANTIS_REPO_CONFIG_JSON"
      value = "{\"repos\":[{\"id\":\"/.*/\",\"allowed_overrides\":[\"apply_requirements\",\"workflow\"],\"allow_custom_workflows\":true}]}"
    },
    {
      name  = "ATLANTIS_CHECKOUT_STRATEGY",
      value = "merge"
    }
  ]
}

output "webhook_url" {
  description = "Github webhook URL"
  value       = module.atlantis.atlantis_url_events
}

output "webhook_secret" {
  description = "Github webhook secret"
  value       = module.atlantis.webhook_secret
}
