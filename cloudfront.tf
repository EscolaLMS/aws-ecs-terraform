locals {
  front_origin_id = "front-alb"
  back_origin_id = "back-alb"
  admin_origin_id = "admin-alb"
}

#resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#  comment = "cloudfront-ecs-demo-webapp-origin"
#}

resource "aws_cloudfront_distribution" "front_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${random_string.name.result}-front"
#  default_root_object = "index.html"

#  origin {
#    domain_name = aws_s3_bucket.cf-s3-ecs-demo-bucket.bucket_regional_domain_name
#    origin_id   = local.s3_origin_id

#    s3_origin_config {
#      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
#    }
#  }

  origin {
    domain_name = aws_alb.front.dns_name
    origin_id   = local.front_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.front_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
      headers = ["*"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }




  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
#      locations        = ["PL","US", "CA", "GB", "DE", "IN", "IR"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
#    ssl_support_method = "sni-only"
#    minimum_protocol_version = "TLSv1.2"
  }
}

resource "aws_cloudfront_distribution" "back_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${random_string.name.result}-back"
#  default_root_object = "index.html"

#  origin {
#    domain_name = aws_s3_bucket.cf-s3-ecs-demo-bucket.bucket_regional_domain_name
#    origin_id   = local.s3_origin_id

#    s3_origin_config {
#      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
#    }
#  }

  origin {
    domain_name = aws_alb.back.dns_name
    origin_id   = local.back_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.back_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
      headers = ["*"]
    }


    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
#      locations        = ["PL","US", "CA", "GB", "DE", "IN", "IR"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
#    ssl_support_method = "sni-only"
#    minimum_protocol_version = "TLSv1.2"
  }
}



resource "aws_cloudfront_distribution" "admin_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${random_string.name.result}-admin"
#  default_root_object = "index.html"

#  origin {
#    domain_name = aws_s3_bucket.cf-s3-ecs-demo-bucket.bucket_regional_domain_name
#    origin_id   = local.s3_origin_id

#    s3_origin_config {
#      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
#    }
#  }

  origin {
    domain_name = aws_alb.admin.dns_name
    origin_id   = local.admin_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.admin_origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
      headers = ["*"]
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }




  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
#      locations        = ["PL","US", "CA", "GB", "DE", "IN", "IR"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
#    ssl_support_method = "sni-only"
#    minimum_protocol_version = "TLSv1.2"
  }
}
