.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
xenial-terminator-zsh: ## Build Xenial Custom Enviroment Container | (non NVIDIA)
	cd generic; ./build.sh codookie/xenial:terminator-zsh 
	@printf "\n\033[92mDocker Image: codookie/xenial:terminator-zsh\033[0m\n"
xenial-terminator-nvidia: xenial-terminator-zsh ## Build Xenial Custom Enviroment Container | (with NVIDIA & OpenGL)
	docker build -t codookie/xenial:terminator-nvidia nvidia-opengl
	@printf "\n\033[92mDocker Image: codookie/xenial:terminator-zsh-nvidia\033[0m\n"
xenial-terminator-cuda: ## Build Xenial Custom Enviroment Container | (with NVIDIA cuDNN)
	cd nvidia-cudnn; ./build.sh  codookie/xenial:terminator-cuda
	@printf "\n\033[92mDocker Image: codookie/xenial:terminator-cuda\033[0m\n"
