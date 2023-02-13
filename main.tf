resource "azurerm_spring_cloud_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  service_name        = var.service_name

  dynamic "identity" {
    for_each = var.identity == null ? [] : [1]
    content {
      type = var.identity
    }
  }
}
