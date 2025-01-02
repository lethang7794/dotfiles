# My dotfiles

[![gitleaks](https://github.com/lethang7794/dotfiles/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/lethang7794/dotfiles/actions/workflows/gitleaks.yml)

## What is this repo?

This repo is for storing my public config files, canonically called _dotfiles_.

> [!TIP]
> This is my first attempt to have experiences with
>
> - Linux (especially Fedora)
> - _Configuration as Code_

> [!CAUTION]
> The configurations may not apply best practices because I don't have much experiences with Linux.
>
> (I switched to Linux one year ago, after more than one year with MacOS, and before that is only Windows)

## Intro

The dotfiles are

- managed with a bare repo (of this repository)
- using techniques and code based on concepts from
  - [mattmc3's dotfiles repo](https://github.com/mattmc3/dotfiles)
  - [Atlassian article on bare repos](https://www.atlassian.com/git/tutorials/dotfiles)
  - and the zillions of other [dotfile repos on GitHub](https://dotfiles.github.io/)

## Get started

### Use this repo as starting point for your dotfiles

To apply the dotfiles in this repo to a new machine, run:

```bash
alias dotty='GIT_WORK_TREE=~ GIT_DIR=~/.dotfiles'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

git clone --bare git@github.com:lethang7794/dotfiles $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no

dotfiles checkout
if [[ $? == 0 ]]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles.bak/{}
fi
```

> [!NOTE]
> After running this, you have:
>
> - `$HOME/.dotfiles`: The bare repo (of this remote repository) with only the `.git` directory.
> - `$HOME`: Acts as a worktree of that bare repo.
>
> See
>
> - <https://git-scm.com/docs/git-clone#Documentation/git-clone.txt-code--barecode>
> - <https://git-scm.com/docs/git-worktree>

### Working with dotfiles

#### Using the CLI

> [!NOTE]
> Instead of using `git` (`git add`, `git commit`...),
>
> - you use `dotfiles` (`dotfiles add`, `dotfiles commit`...)

- Add changes files to the index (of local repo)

  ```bash
  dotfiles add path/to/file
  ```

- Commit files to the local repo

  ```bash
  dotfiles commit -m "message"
  ```

- Push commit to remote repo (this repo)

  ```
  dotfiles push
  ```

## References

<details>
<summary>Chezmoi</summary>

## How chezmoi works?

### chezmoi concepts

|             | Destination Dir                      | Source Dir                              | Target                                                     |
| ----------- | ------------------------------------ | --------------------------------------- | ---------------------------------------------------------- |
| What is it? | The directory that `chezmoi` manages | Where `chezmoi` stores the source state | a file, directory, or symlink in the destination directory |
| Example     | `~`                                  | `~/.local/share/chezmoi`                | (temporary file)                                           |
|             |                                      |                                         |

|             | Destination State                                             | Source State                         | Target State                                |
| ----------- | ------------------------------------------------------------- | ------------------------------------ | ------------------------------------------- |
| What is it? | Current state of all the targets in the destination directory | Desired state of your home directory | Desired state of the destination directory. |
| Example     | `~/.zshrc`                                                    | `~/.local/share/chezmoi/dot_zshrc`   | `/tmp/chezmoi-merge1615707743/.zshrc`       |
|             |                                                               |                                      |

### How chezmoi apply the state to each target?

1. Read the source state.
2. Read the destination state.
3. Compute the target state.
4. Run run _before_ scripts in alphabetical order.
5. Update entries in the target state (files, directories, externals, scripts, symlinks, etc.) in alphabetical order of their target name.

   Directories (including those created by externals) are updated before the files they contain.

6. Run run _after_ scripts in alphabetical order.
</details>

<details>
<summary>
Config references
</summary>

|       | Where is the config? | Configuration structure          | Docs                                    |
| ----- | -------------------- | -------------------------------- | --------------------------------------- |
| broot | `~/.config/broot`    | `conf.hjson`: Config             | <https://dystroy.org/broot/conf_file/>  |
|       |                      | `verbs.hjson`: Keyboard shortcut | <https://dystroy.org/broot/conf_verbs/> |
|       |                      |                                  |                                         |

</details>
