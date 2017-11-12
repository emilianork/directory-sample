# Directory sample

## Project requiriments and documentation

https://github.com/emilianork/directory-sample/blob/master/docs/design.org

## Install steps

## Dependencies

- Ruby 2.3
- MySQL 5.6

## Install Docker

```https://www.docker.com```

Install Jet

```sh
$ brew cask install jet
```

## Testing

Run

```sh
$ jet steps
```

## Development

Run docker container

```sh
$ docker-compose -f codeship-services.yml up
```

Enter main service using

```sh
$ docker-compose -f codeship-services.yml exec ruby /bin/bash
```

The first time the container is up, run:

```sh
$ cd /app
$ bundle install
$ rake db:setup
```

Run tests using:

```sh
$ rspec
```
