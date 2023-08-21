apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment_testing
  labels:
    app: testing
spec:
  replicas: 2 
  selector:
    matchLabels:
      app: testing
  template:
    metadata:
      labels:
        app: testing
    spec:
      containers:
      - name: websrv01
        image: 826316/k8proj
        ports:
        - containerPort: 80 
