app = php-app

build:
	docker build -t $(app) .
run:
	docker run -d -p 8080:80 --name $(app) $(app)
stop:
	docker container stop $(app)
	docker container rm $(app)
clean:
	#docker system prune -a
