

 # resource "aws_instance" "webserver" {
 #   ami           = "ami-078a289ddf4b09ae0"
 #   instance_type = "t2.nano"
 #   tags = {
 #     Name = "ProjectA-Webserver"
 #   }
 #   lifecycle {
 #     ignore_changes = all
 #   }
 # }




order   option
1       create_before_destroy    Create the resource first and then destroy
                                 older

2       prevent_destroy          Prevents destroy of a resource 

3       ignore_changes           Ignore Changes to Resource Attributes
                                 ( specific/all )
