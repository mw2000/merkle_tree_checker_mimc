# Merkle Tree Checker in Noir
This repository contains an implementation of a Merkle Tree Checker written in Noir, a domain-specific language designed for zero-knowledge proofs. The Merkle Tree Checker verifies the correctness of a Merkle proof for a given Merkle root and leaf.

## Introduction
The Merkle Tree Checker is a crucial component in many cryptographic protocols, providing a way to efficiently and securely verify the integrity of data. This implementation in Noir leverages the language's capabilities for creating concise and secure zero-knowledge proofs.

## Installation
Before you can use this implementation, ensure you have the Noir language and its dependencies installed. For the latest installation instructions, please refer to the [Noir documentation](https://noir-lang.org/).

To import this as a dependency in your noir project, please add this to your nargo`[dependencies]`. Replace the tag with the version you wish to use.
```
merkle_tree_checker_mimc = { tag = "v0.0.1", git = "https://github.com/mw2000/merkle_tree_checker_mimc" }
```

## Usage
To use the Merkle Tree Checker in your Noir project, you can call the `merkle_tree_checker` function with the appropriate parameters:

```rust
use merkle_tree_checker::merkle_tree_checker;

let leaf = 1;
let root = hash_left_right(1, 2); // Assuming a simple Merkle tree with one level
let path_elements = [2];
let path_indices = [0];
let is_valid = merkle_tree_checker(leaf, root, path_elements, path_indices);
assert(is_valid == true);
```

## Disclaimer
This Merkle Tree Checker implementation is provided as-is without any warranty. It has not been audited and is not guaranteed to be secure. It is intended for educational and research purposes only. Users should conduct their own due diligence and risk assessment before deploying it in production environments or for high-stakes applications.

## Contributing
Contributions to improve the implementation are welcome. Please submit a pull request or open an issue if you have suggestions or identify any problems.

## License
This project is licensed under the [MIT License](). Feel free to use, modify, and distribute the code as per the license terms.