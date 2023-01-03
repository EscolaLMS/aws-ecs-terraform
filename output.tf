output "cloudfront_dns_back" {
  value = "https://${aws_cloudfront_distribution.back_distribution.domain_name}"
}

output "cloudfront_dns_front" {
  value = "https://${aws_cloudfront_distribution.front_distribution.domain_name}"
}

output "cloudfront_dns_admin" {
  value = "https://${aws_cloudfront_distribution.admin_distribution.domain_name}"
}