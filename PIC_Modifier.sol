// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

abstract contract PIC_Modifier {

    modifier mintNFTModifier() {
        // function前
        _;
        // function後
    }
}
