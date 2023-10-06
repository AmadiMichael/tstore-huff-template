# Transient Store Foundry Template

A foundry template that supports transient storage opcodes in huff language using `__VERBATIM(0x5c)` and `__VERBATIM(0x5d)` for tload and tstore respectively.

## Example contract

```solidity
/// @dev INTERFACE
#define function tstore(uint256 slot, uint256 value) payable returns()
#define function tload(uint256 slot) payable returns(uint256)


/// @dev ENTRY POINT
#define macro MAIN() = {
    0x00 calldataload 0xe0 shr                              // [functionSig]

    dup1 __FUNC_SIG(tstore) eq tstore_impl jumpi            // [functionSig]
    __FUNC_SIG(tload) eq tload_impl jumpi                   // []
    0x00 0x00 revert

    tstore_impl:
        TSTORE_IMPL()

    tload_impl:
        TLOAD_IMPL()
}


#define macro TSTORE_IMPL() = {
    0x24                                                    // [0x24]
    calldataload                                            // [value]
    0x04                                                    // [0x04, value]
    calldataload                                            // [slot, value]
    __VERBATIM(0x5d) // tstore                              // []

    stop
}

#define macro TLOAD_IMPL() = {
    0x04                                                    // [0x04]
    calldataload                                            // [slot]
    __VERBATIM(0x5c) // tload                               // [value]
    0x00                                                    // [0x00, value]
    mstore                                                  // []

    0x20                                                    // [0x20]
    0x00                                                    // [0x00, 0x20]
    return                                                  // []
}
```
