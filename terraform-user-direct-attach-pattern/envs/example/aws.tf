provider "aws" {
  alias = "account-identity"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_IDENTITY_ACCOUNT"
  }
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "account-a"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_ACCOUNT_A"
  }
  region = "ap-northeast-1"
}

provider "aws" {
  alias = "account-b"
  assume_role {
    role_arn = "YOUR_ROLE_FOR_ACCOUNT_B"
  }
  region = "ap-northeast-1"
}
