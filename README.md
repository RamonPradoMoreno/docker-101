# Docker 101

This guide is **extremely simplified**. It is intended for people that want to learn the basics, a great starting point.

## What is docker?

Docker is a platform for developers and sysadmins to **build, run, and share** applications with containers. 

## How do I get docker?

Follow the [official docs](https://docs.docker.com/get-docker/).

## Docker vs Virtual Machine

A container runs *natively* on Linux and shares the kernel of the host machine with other containers. It runs a discrete process, taking no more memory than any other executable, making it lightweight.

By contrast, a **virtual machine** (VM) runs a full-blown “guest” operating system with *virtual* access to host resources through a hypervisor. In general, VMs incur a lot of overhead beyond what is being consumed by your application logic.

## Basic Elements

This are the elements that interact to help you build applications:

### Images

Images are templates for the applications that you will run. To build an image you need a `Dockerfile`. This files are simple `yaml` files that describe the image.

### Containers

Containers are processes. An instance of an image that is running. 

*For example*: If you need an elasticsearch cluster of two machines they will both use the same image but will be two different containers, each one with it's own configuration.

### Networks

When running containers you may attach them to networks so they can communicate with each other. You can find more info [here](https://github.com/RamonPradoMoreno/docker-networks)

### Volumes

All information in a container is ephemeral. In order to persist or share information with containers you will need to use volumes. You can find more info [here](https://github.com/RamonPradoMoreno/learned-at-work/wiki/Data-Persistence)

### docker-compose

Docker-compose is a CLI tool that reads a `docker-compose.yaml` file to set up a container environment. It takes care of image generation and container creation and execution.

## Basic CLI

Now that we know how it works we are going to use docker.

### Image creation

In order to create an image we simply need to execute:

```bash
# The last dot is setting up the context, 
#the dir where docker will look for all the files to generate the image
docker image build -t my_image:0.0.1 .
```

This will trigger first the image download, We need to get the `FROM` image first. Then our data will be written onto that image to generate our custom image `my_image`

Once it is done if you execute:

```bash
docker image ls
```

You will be able to see your image.

### Container creation

Since we just created an image we will be using it to create a container:

```bash
docker container create --name my_container my_image:0.0.1
```

Now execute:

```bash
docker container ls
```

You should see **nothing**. This is because that command only shows running containers and ours is not running yet.

Try:

```bash
docker container ls -a
```

Now you will see it is in `CREATED` state.

Let's start it:

```bash
docker container start  my_container  
```

Let's see if it is running ok by checking the logs:

```bash
# -f waits for new lines, exit with ctrl+C
docker container logs my_container -f
```

*Note*: Check the `docker container run` command. It is container [creation and execution in one step](https://docs.docker.com/engine/reference/commandline/run/).

### Usage of docker-compose

We will use our docker-compose to do the same thing but much quicker. Before starting the section execute this commands to make sure we have no containers:

```bash
docker container stop my_container
docker container rm my_container  
```

Now we can build all images in the compose by running:

```bash
docker-compose build
```

And then create and start all containers in one step:

```bash
# -d is to start the containers dettached and don't block the terminal
docker-compose up -d
```

You can either check the logs per container or check all logs for a docker-compose with:

```bash
docker-compose log -f
```

To leave your docker clean from all images and containers we have created run:

```bash
# -v deletes all volumes created with the compose
# --rmi deletes all images created with the compose
docker-compose down -v --rmi all
```

## Next steps

If you want to learn more I recommend to:

1. Use the official docs when you don't understand something. You can find them [here](https://docs.docker.com/).
2. Check out my other repos to go deeper into [Volumes](https://github.com/RamonPradoMoreno/learned-at-work/wiki/Data-Persistence) and [Networks](https://github.com/RamonPradoMoreno/docker-networks).
3. Check a cool working example: You can check an Elasticsearch stack run with a compose at [this repo](https://github.com/RamonPradoMoreno/elk-docker-playground).