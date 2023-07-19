# KI sh <a href=https://en.wikipedia.org/wiki/Qi > き </a>

#  <a href=https://github.com/ki-sh/kishcore > KISHCORE き </a>

* Easily create/customise/manage command line shortcut alaises, scripts.
* Never have to type cd, or its evil twin cd .. again!
* Never loose your shell aliases/easily share between devices/teams. Save in your own repo (from <a href=https://github.com/ki-sh/kish >Template</a>)


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


* Zero dependencies. Simple to use shell test framework (KIT).Tcho Bats?
* Ubiqutous v3 portable pure shell script.
* Comes with very useful example scripts:
  * ocal : fast easy human cli for creating calendar events.
  * omap : open maps with location or directions



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
```$>ki     # shows the help generated from your aliased commands.```
```$>kiu    # updates changes to your aliases. Note can run from anywhere.```
```$>kin    # runs a wizzard to create a new command.```

Please Star the <a href="https://github.com/ki-sh/kishcore"> kishcore repo </a> to be alerted to
core shared updates. (This separation enables shared enhancements as well as your own source control over your own scripts/aliases.)


Congratulations, you are on the flow-full path of never using cd .. again!

Coming soon:  video showing the features of ki, with an example of one way of using it
in a polyrepo scenario.

## familiarize
ki powered commands work thus:
```ki anycommand anydirectores anyfiles anything_else_are_args_to_the_command.```
ki visits into the directories given, runs the command and comes back out. Simple really. Why did we never have this before?!
The order of files args commands does not matter.


```
ki cat kish/aliases/o*.sh  # ki anycmd 
kin    # choose options: kat, cat, y. 
kiu
# start new terminal,
kat kish/aliases/k*.sh # you just created your own first alias.
# to remove an alias use kix:
kix kat
# this moves kat from aliases to aliases/parked.
# any command in aliases are made live with kiu. You can 'park' scripts in any subdir off aliases.
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



