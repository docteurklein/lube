resource "null_resource" "test" {
  triggers = {
    test = "test2"
  }
  provisioner "local-exec" {
    command = "echo test2"
  }
}
