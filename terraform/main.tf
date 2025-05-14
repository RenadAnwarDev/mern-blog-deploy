data "aws_vpc" "default" {
  default = true
}


# ------------------------------
# S3 Bucket for Media Uploads
# ------------------------------
resource "aws_s3_bucket" "media_bucket" {
  bucket = "mern-media-rinad"

  tags = {
    Name = "Media Bucket"
  }
}

# ------------------------------
# IAM User for Media Bucket Access
# ------------------------------
resource "aws_iam_user" "s3_user" {
  name = "s3-upload-user"
}

resource "aws_iam_access_key" "s3_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_user_policy" "s3_policy" {
  name = "s3-upload-policy"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "${aws_s3_bucket.media_bucket.arn}",
          "${aws_s3_bucket.media_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_security_group" "blog_sg" {
  name        = "blog-sg"
  description = "Allow HTTP, SSH, and App Port"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "blog_backend" {
  ami                    = "ami-09fdd0b7882a4ec7b" # Ubuntu 22.04 - eu-north-1
  instance_type          = "t4g.micro"
  key_name               = "Renad-key-2025"
  vpc_security_group_ids = [aws_security_group.blog_sg.id]
  user_data              = file("${path.module}/user-data.sh")

  tags = {
    Name = "mern-backend-instance"
  }
}