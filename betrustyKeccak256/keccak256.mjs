import { ethers } from "ethers"

const message = ethers.solidityPackedKeccak256(
    ['uint256'],
    ["1"]
)

console.log("message : ", message)