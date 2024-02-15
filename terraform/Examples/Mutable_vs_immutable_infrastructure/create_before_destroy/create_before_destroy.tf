
resource "local_file" "pet" {
  filename = var.filename
  content  = "we love pets"
  file_permission = "0700"

   lifecycle {
     create_before_destroy = true
   }

}
