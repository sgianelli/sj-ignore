# sj-ignore

This small utility makes generating a .gitignore file for a new project as
painless as possible when dealing with multiple platforms or languages that you
require .gitignore info for. Currently the program uses
[Github's gitignore](https://github.com/github/gitignore) repository to provide
a wide list of established .gitignore files.

## Installation

    gem install sj_ignore

## Example

To use this by pulling down a local copy of the github/gitignore repository
into the gem's installed lib/ directory:

    sj_ignore ruby vim osx > .gitignore

To use GitHub's API to fetch files remotely:

    sj_ignore -a ruby vim osx > .gitignore

## TODO

Pull `github/gitignore` repository so there is a local copy on the machine in
order to speed up setup time and to avert the issue with github api rate
limiting.

Give option to define your own github repository of .gitignore files.
