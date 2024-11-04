const { randomBytes, getBigInt } = require("ethers");

const num = 10;

async function gen() {
    for (let i = 0; i < num; i++) {
        let n = getBigInt("0x" + Buffer.from(randomBytes(32)).toString("hex"));
        console.log(n.toString());
    }
}

gen().catch((error) => {
    console.error(error);
});
