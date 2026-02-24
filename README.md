**ty LSP settings in pyproject.toml**

```
[tool.ty.environment]
python = "../../../version-13/env"
extra-paths = ["../frappe"]
```
**tree-sitter issues** 
The error "tree-sitter version GLIBC_2.39' not found" occurs when the **tree-sitter` binary** you are trying to run was compiled against a newer version of GLIBC so i download tree-sitter 24.0

Remove current version of tree-sitter
```
npm uninstall -g tree-sitter-cli
```
Download older version from ```https://github.com/tree-sitter/tree-sitter/tags```

unzip tree-sitter you download, and move binary file into  ~/.local/bin/
```bash
gzip -d tree-sitter-linux-x64.gz
cd tree-sitter-linux-x64
sudo chmod +x tree-sitter
```
Run ```which tree-sitter``` and replace existing one
```bash
mv tree-sitter path/to/existing/tree-sitter
```
check version if suitable

tree-sitter --version
