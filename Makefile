.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
xenial-terminator-zsh: ## Build Xenial Custom Enviroment Container | (no OpenGL/NVIDIA)
	cd no-opengl; ./build.sh codedookie/xenial:terminator-zsh 
	@printf "\n\033[92mDocker Image: codedookie/xenial-terminator-zsh\033[0m\n"
xenial-terminator-zsh-opengl: ## Build Xenial Custom Enviroment Container | (with OpenGL/NVIDIA)
	cd nvidia-opengl; ./build.sh codedookie/xenial:terminator-zsh-nvidia-opengl
	@printf "\n\033[92mDocker Image: codedookie/xenial:terminator-zsh-nvidia-opengl\033[0m\n"

