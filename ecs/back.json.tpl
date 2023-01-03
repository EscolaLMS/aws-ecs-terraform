[
  {
    "name": "${name}-back",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "command": ["/bin/sh -c \"/docker-entrypoint.sh && /var/www/html/init.sh && chown -R devilbox:devilbox /var/www/html && php artisan db:seed --force --no-interaction && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf \""],
    "entryPoint": [
      "sh",
      "-c"
    ],
    "mountPoints": [
      {"sourceVolume": "storage", "containerPath": "/var/www/html/storage","readOnly": false}
    ],
    "environment": [
      {"name": "LARAVEL_DB_DATABASE", "value": "sa"},
      {"name": "LARAVEL_DB_USERNAME", "value": "sa"},
      {"name": "LARAVEL_REDIS_PASSWORD", "value": "  "}
    ],
    "secrets": [
      {"name": "LARAVEL_DB_PASSWORD", "valueFrom": "${db_password}"},
      {"name": "LARAVEL_DB_HOST", "valueFrom": "${db_host}"},
      {"name": "LARAVEL_REDIS_HOST", "valueFrom": "${redis_host}"},
      {"name": "LARAVEL_APP_URL", "valueFrom": "${back_url}"}
    ],
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/${name}/back",
          "awslogs-region": "${region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]