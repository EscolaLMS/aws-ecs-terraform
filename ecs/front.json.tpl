[
  {
    "name": "${name}-front",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "secrets": [
      {"name": "API_URL", "valueFrom": "${back_url}"}
    ],
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/${name}/front",
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