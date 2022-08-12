
module "create_two_lambdas" {
  source   = "./terraform_module"
  lambda_1 = "print_something"
  lambda_2 = "print_something_second_time"
}