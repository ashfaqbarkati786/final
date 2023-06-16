terraform {
  backend "azurerm" {
    storage_account_name = "terraformbackend6786"
    container_name       = "terraformbackend"
    key                  = "backend"
    access_key           = "QwTUBgocBxn/aE85iJYUUsQRBsRL8MrDFJiN338PZuB3IJ/1TEWVT0mCDNHm5HepsMEGeN9KBTk4+AStvo4ZQQ=="
    resource_group_name  = "ashfaq-project"
  }
}
