.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9a-zA-Z_-]+:.*?## / {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
xenial-terminator-zsh: ## Build Xenial Custom Enviroment Container | (non NVIDIA)
	cd generic; ./build.sh codedookie/xenial:terminator-zsh 
	@printf "\n\033[92mDocker Image: codedookie/xenial-terminator-zsh\033[0m\n"
xenial-terminator-zsh-nvidia: ## Build Xenial Custom Enviroment Container | (with NVIDIA/OpenGL)
	cd nvidia-opengl; ./build.sh codedookie/xenial:terminator-zsh-nvidia
	@printf "\n\033[92mDocker Image: codedookie/xenial:terminator-zsh-nvidia\033[0m\n"
