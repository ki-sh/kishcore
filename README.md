# KI sh <a href=https://en.wikipedia.org/wiki/Qi > き </a>

click 'Use this template' button on  <a href=https://github.com/ticaboo/kish >this page</a>
Do not npm i.

* Easily create/customise/manage command line shortcuts.
* Superpowered! Execute across child directories.
* Standardise shortcuts across organisation.
* portable pure shell script, zero dependencies.

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

## Install
click 'Use this template button' on  <a href=https://github.com/ticaboo/kish >this page</a>
```
cd kish
npm i
npm run kiu
source ~/.zshrc

ki
```

ki shows the help generated from your aliased commands.
kin runs a wizzard to create a new command.

try it out to get familiar:

```
$> kin
Enter command name:             hello
Enter what command executes:    echo "hello world $PWD" 
Should this command be runnable in different folders/files? (y/n)   Y

kiu
source ~/.zshrc (if making new command need to do this)
```

After first install, ki, kin, kiu etc. can be run from anywhere, so you dont have to 
cd kish to work with it.

Have a look at the hello.sh script that was created. You can easily code the scripts,
easy to hack all the scripts to your requirements.


try hacking a command- create a file: kish/aliases/ge.sh
```
 st="ge"
 cmd="ga gc $1 push"
~/.kish/ga.sh && ~/.kish/gc.sh "$1" && ~/.kish/push.sh  

kiu
source ~/.zshrc
#this will add, commit, push on any child repos - so careful
ge adds-all-commits-this-message-pushes-all-on-all-child-repos-sweet
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

But its more than just about saving keystrokes. The long commands cause mental impedence. You will quickly find what were chores before become second nature flow. And flow matters.

Cli designed for mono/hybrid/poly repos. By default every command runs across multiple targets.


## Execute across child directories at once.

By default any ki shortcut will execute in every first child directory:
```
/top
    /apps
    /packages

$> l 

./apps:
    acme
    ozcorp
    skynet
    wayne

./packages:
    middleware
    services
    uicomponents
```
dot or trialing dot targets a single directory:
```
$> l .
    apps
    packages

gs packages 
-executes for all child dirs of packages.
gs packages/uicomponents/. 
-executes only for uicomponents
```
This truey is an amazing super power. Inspired by monorepo tools.
For one thing it means you very rarely use cd, and it's evil twin cd ../.. etc.
This, even more than the shortcut management boosts productivity to the next level.





## filtering

There are two ways of filtering the directories commands act on.
Allowables and workspaces.

### allowables
An allowable is a file/directory that must be in the target directory for it to be allowed to execute.
For example 99% of git commands you only run in git initialised folder.

The exceptions are general utilitites/remote actions/creational commands.
l (ls -1 --color ) is a general utility.
g is general, for example g clone
gh commands are mostly remote.



### Vscode Workspaces

This feature allows all ki commands to be fitlered to an active vscode workspace. 
kiwi wsfile - workspace incept a workspace file.
kiwix  - removes filtering for active ws file.

Try keeping your workspaces in the kish workspaces folder. Can be very useful for 
complex features across many diretories / files. Try naming by feature &/ issue number.

