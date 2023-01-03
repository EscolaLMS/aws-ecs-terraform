resource "aws_iam_policy" "update_services_esc" {
  name        = "${random_string.name.result}_update_services_ecs"
  path        = "/"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ecs:UpdateService",
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "ecs:cluster": "${aws_ecs_cluster.cluster1.arn}"
                }
            }
        }
    ]
})
}
