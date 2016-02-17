# Marty - command line to mange swarm cluster with ease :)

## Highlight:

```
➜  marty git:(master) ✗ marty
Usage:
    marty [OPTIONS] SUBCOMMAND [ARG] ...

Parameters:
    SUBCOMMAND                    subcommand
    [ARG] ...                     subcommand arguments

Subcommands:
    create                        Create things
    create                        create a new grid
    rm, remove, destroy           create a new grid
    ls                            list machines
    upgrade                       upgrade docker-*

Options:
    -h, --help                    print help
➜  marty git:(master) ✗
```

```
marty create grid cluster1
marty create node -j cluster1 --master node1
marty create node -j cluster1  node2
```

## TODO

- [ ] better doc
