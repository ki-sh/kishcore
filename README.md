#  <a href=https://github.com/ki-sh/kishcore > KISHCORE き </a>

# KI sh <a href=https://en.wikipedia.org/wiki/Qi > き </a>

* Ki sh is a lean alternative to 'oh my zsh', but both can be used on any platform.
* Easily create/customise/manage command line shortcut alaises, scripts.
* Never have to type cd, or its evil twin cd .. again!
* Never loose your shell aliases/easily share between devices/teams. Save in your own repo (from <a href=https://github.com/ki-sh/kish >Template</a>)
* Auto generated help page of your aliases (ki). Easily control your Aliases, unlike 'oh my zsh' which by default innundates with far too many.


```
            .,ad88888888baa,
        ,d8P"""        ""9888ba.
     .a8"          ,ad88888888888a
    aP'          ,88888888888888888a
  ,8"           ,88888888888888888888,
 ,8'            (888888888888888888888,
,8'    ***   **  `88888888888   88888888        ********   **      **
8)     ***  **    `888888888888888888888,      **//////   /**     /**
8      *** **       "88888888   88888888)     /**         /**     /**
8      *****          `888888   88888888)     /*********  /**********
8)     ***/ **         "88888   88888888      ////////**  /**//////**
(b     ***/  **          "888   8888888'             /**  /**     /**
`8,    ***/  ****        8888   888888)        ********   /**     /**
 "8a                   ,888888888888)        ////////    //      // 
   V8,                 d88888888888"
    `8b,             ,d8888888888P'
      `V8a,       ,ad8888888888P'  
         ""88888888888888888P"     
              """"""""""""
```


* Zero dependencies. Simple to use shell test framework (KIT).Provides x-tests, only-tests, no DSL. It is an alternative to Bats shell script testing when you want something no setup, simple quick and easy to use.
* Ubiqutous v3 portable pure shell script.
* Comes with useful example scripts:
  * ocal : fast easy human cli for creating calendar events.
  * omap : open maps with location or directions
  * and so much more.


## Install
click Use this template button on  <a href=https://github.com/ki-sh/kish >this page</a>.
Then clone your repo and:
```
cd kish
npm i
npm run kiu
source ~/.zshrc # or restart terminal

ki
```
Run from anywhere:

* `$>ki     # shows the help generated from your aliased commands. ki cmd - gives any command anti-cd api.`

* `$>kin    # new command wizzard.`

* `$>kiu    # update changes to your aliases. `
 


Please Star and Watch the <a href="https://github.com/ki-sh/kishcore"> kishcore repo </a> to be alerted to
core shared updates. (This separation enables shared enhancements as well as your own source control over your own scripts/aliases.)


Congratulations, you are on the flow-full path of never using cd .. again!



## Familiarize
ki powered commands work thus:
  ```
  ki anycommand anydirectores anyfiles anything_else_are_args_to_the_command
  ```
ki visits into the directories given, runs the command and comes back out. Simple really. Why did we never have this before?!
The order of files args commands does not matter.

Try this to familiarize yourself with ki:

```
ki cat kish/aliases/o*.sh 
kin    # choose options: kat, cat, y. 
kiu
# start new terminal,
kat kish/aliases/k*.sh 
# you just created and ran your own first alias.
# to remove an alias use kix:
kix kat
# this moves kat from aliases to aliases/parked.
# any command in aliases are made live with kiu. You can 'park' scripts in any subdir off aliases.
```

## poly repo example
Git and NPM/Yarn etc require you to be in a directory at or below their configuration file(s).
(.git for git, package.json for npm).
They bubble up from subdirectories until they find the configuration. 

Ki works with this so you can stay in any directory - usually an outer higher level one. This is typical of working with mono-repos. Any ki commands take care of navigating into the desired directories.

[ video ]

Follow allong these steps to replicate the actions shownn in the video:

```
# if you havent already, install ki as shown above.
# make a temporary directory and cd into it.
mkdir kipolydemo && cd kipolydemo

# Lets grab the demonstration poly repo:
git clone https://github.com/ki-sh/poly-ex.git

# here we go - no cd poly_ex, cd .. after. good riddance cd!
nr poly-ex clone:all

# you now have multiple repos cloned to apps/ and packages/. Take a look:
l apps/* packages/*

# lets checkout a new branch called 'setup' on them all:
gcob setup  apps/* packages/*

# and lets see the new branch has been created:
gb apps/* packages/*

# say we want each of them to have npm package:
n init -y apps/* packages/*

# say you wanted to run all the tests in all the repos in one go:
nr apps/* packages/* test
# the default test action - no tests found are run.

# lets do some source control
# you can specify files:
ga apps/w*/package.json

# or directories:
ga apps/* packages/*

# check git status is added:
gs apps/* packages/*

# commiting:
gc 'npm initialised' apps/* packages/*

# you wont have access to push as this is a demo and checked out with http, but if you did,can simply:
gpu apps/* packages/*

# another cool thing is the order of the parms dont matter, these are all equivalent:
gc 'my commit message' apps/* packages/ui_components/pacakge.json
gc  apps/* 'my commit message' packages/ui_components/pacakge.json
gc  apps/* packages/ui_components/pacakge.json 'my commit message'


```

## saves you a ton of typing, ramps up flow:

| strokes saved | ShortTask | long equivalent                 |
| ------------- | --------- | ------------------------------- |
| 2             | g         | git                             |
| 5             | ga        | git add .                       |
| 8             | gb        | git branch                      |
| 12            | gc        | git commit -m ''                |
| 29            | gca       | git commit -a --amend --no-edit |
| 11            | gco       | git checkout                    |
| 13            | gcob      | git checkout -b                 |
| 10            | gs        | git status -s -b                |
| 1             | h         | gh (github-cli)                 |
| 4             | pull      | git pull                        |
| 4             | push      | git push                        |
| 23            | pushnew   | git push --set-upstream origin  |
| 6             | n         | npm run                         |
| 7             | pn        | pnpm run                        |
| 2             | y         | yarn                            |

- Quick setup / update.
- Easy to configure / adapt / make your own.
- Singe / multiple targets simultaneously.
- No dependencies. - pure shell scripts.
- Useful for any language, version control, packaging system.

But its more than just about saving keystrokes. The long commands cause mental impedence. Let alone cd/cd ../..etc. You will quickly find what were chores before become second nature flow. And flow matters. 



## Roadmap

Coming soon - filter to vscode workspaces. 

## common questions
* if you move kish, simply update the KISHPATH in your shell profile (eg $HOME/.zshrc / $HOME/.bashrc)
* to check for updates, and keep up to date with kish core features, you can use ```$> nup kish```.

