# My dotfiles

[![gitleaks](https://github.com/lethang7794/dotfiles/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/lethang7794/dotfiles/actions/workflows/gitleaks.yml)

## What is it?

<!-- TODO -->

## Why use it?

<!-- TODO -->

## Getting started

<!-- TODO -->

## How to modify

<!-- TODO -->

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

---

<details>
<summary>
Reference
</summary>

|       | Where is the config? | Configuration structure          | Docs                                  |
| ----- | -------------------- | -------------------------------- | ------------------------------------- |
| broot | `~/.config/broot`    | `conf.hjson`: Config             | https://dystroy.org/broot/conf_file/  |
|       |                      | `verbs.hjson`: Keyboard shortcut | https://dystroy.org/broot/conf_verbs/ |
|       |                      |                                  |                                       |

</details>
