# sj-ignore

This small utility makes generating a .gitignore file for a new project as
painless as possible when dealing with multiple platforms or languages that you
require .gitignore info for.

## Installation

    gem install sj-ignore

## Example

    sj-ignore ruby vim osx > .gitignore

## TODO

Pull `github/gitignore` repository so there is a local copy on the machine in
order to speed up setup time and to avert the issue with github api rate
limiting.

Give option to define your own github repository of .gitignore files.
