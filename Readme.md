# homebrew-arcaneframework

A [Homebrew](https://brew.sh) tap for installing
- [hypre](https://github.com/hypre-space/hypre.git) Int32 version.
- [Arcane Framework](https://github.com/arcaneframework/framework) and related tools.
- [ArcaneFEM](https://github.com/arcaneframework/arcanefem) 

## Quick Start

### Prerequisites

- **Homebrew**: Ensure you have Homebrew installed on your system
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- **System Requirements**: 
  - x86 or ARM64 CPU
  - macOS or Linux
  - C++ compiler with C++20 support or higher

### Installations

for installing any of the following add the tap first
```bash
brew tap mohd-afeef-badri/arcaneframework
```

#### hypre-int32:
```bash
brew install hypre-int32
```
> 32 bit Integer version installed with `gcc`, `open-mpi`, `openblas` 

#### Arcane Framework
```bash
brew install --HEAD arcane-framework
```
> HEAD version installed with `gcc` `open-mpi` `openblas` `hypre-int32` `petsc` `hdf5-mpi` `scotch`

#### ArcaneFEM
```bash
brew install --HEAD arcanefem
```
> HEAD version installed with `gcc` `open-mpi` `openblas` `hypre-int32` `petsc` `hdf5-mpi` `scotch` `arcane-framework`


Or install `X` directly without adding the tap:
```bash
brew install mohd-afeef-badri/arcaneframework/X
```

---

*For more information about using Homebrew taps, visit the [official Homebrew documentation](https://docs.brew.sh/Taps).*