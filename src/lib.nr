// Implementing a Merkle tree checker in Noir 
// using MiMC hash function.

// Based on original circom code by Roman Storm 
// https://github.com/tornadocash/tornado-core/blob/master/circuits/merkleTree.circom

use mimc_sponge::mimc_sponge;

// Computes MiMC([left, right])
fn hash_left_right(left: Field, right: Field) -> Field {
    let hasher: [Field; 1] = mimc_sponge([left, right], 1);
    hasher[0]
}

// if s == 0 returns [in[0], in[1]]
// if s == 1 returns [in[1], in[0]]
fn dual_mux(input: [Field; 2], s: Field) -> [Field; 2] {
    assert(s * (1 - s) == 0);
    let out0 = (input[1] - input[0]) * s + input[0];
    let out1 = (input[0] - input[1]) * s + input[1];
    [out0, out1]
}

// Verifies that merkle proof is correct for given merkle root and a leaf
// path_indices input is an array of 0/1 selectors telling whether given path_element is on the left or right side of merkle path
pub fn merkle_tree_checker(leaf: Field, root: Field, path_elements: [Field], path_indices: [Field]) -> bool {
    let levels = path_elements.len();
    let mut current_hash = leaf;

    for i in 0..levels {
        let muxed = dual_mux([current_hash, path_elements[i]], path_indices[i]);
        current_hash = hash_left_right(muxed[0], muxed[1]);
    }

    current_hash == root
}

#[test]
fn test_hash_left_right() {
    let left = 1;
    let right = 2;
    let expected_hash: [Field; 1] = mimc_sponge([left, right], 1);
    let result = hash_left_right(left, right);
    assert(result == expected_hash[0]);
}

#[test]
fn test_dual_mux() {
    let input = [1, 2];
    let s0 = 0;
    let s1 = 1;
    let result0 = dual_mux(input, s0);
    let result1 = dual_mux(input, s1);
    assert(result0 == [1, 2]);
    assert(result1 == [2, 1]);
}

#[test]
fn test_merkle_tree_checker() {
    // Test case 1: Valid Merkle proof
    let leaf = 1;
    let root = hash_left_right(1, 2); // Assuming a simple Merkle tree with one level
    let path_elements: [Field] = [2];
    let path_indices: [Field] = [0];
    let result = merkle_tree_checker(leaf, root, path_elements, path_indices);
    assert(result == true);

    // Test case 2: Invalid Merkle proof
    let invalid_root = 0;
    let invalid_result = merkle_tree_checker(leaf, invalid_root, path_elements, path_indices);
    assert(invalid_result == false);

    // Test case 3: Another valid Merkle proof with different path
    // let leaf2 = 3;
    // let root2 = hash_left_right(3, 4);
    // let path_elements2: [Field] = [4];
    // let path_indices2: [Field] = [1];
    // let result2 = merkle_tree_checker(leaf2, root2, path_elements2, path_indices2);
    // assert(result2 == true);
}