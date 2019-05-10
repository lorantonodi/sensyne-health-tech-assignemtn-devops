## Makefile

.DEFAULT_GOAL := container-build

container-build:
	docker build --no-cache -t lorantonodi/flask-sample:latest -f ./flask-sample/Dockerfile ./flask-sample/

container-push: container-build
	docker push lorantonodi/flask-sample:latest

