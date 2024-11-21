// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Hasher {
    
    uint256 nRounds = 10;
    uint256[10] c = [
        0,
        11790748410223527345390909814687588371885382763772825351543167470901489816612,
        1002911549339539658377423200448895511474178099785226016109980086225434649323,
        110242190823325713623819971200196769803001304286517225150399186566638673949080,
        92253590274059621527484079561227874122059465975149439263549011875387910519048,
        36447742275481271534062510815616296830770662941608263027911487293204752229286,
        48208090328584166326818154547132934836692048925297693078917257437796899782898,
        87766239400783694851720975669017450970854610841971927525170120558046215505984,
        83290340443567497470632107297170015013685643518332343682124543593529032761066,
        300388232167470216951765200439909111049689701122247191508120485124813329604
    ];
    
    uint256 p = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    function MiMC5(uint256 x, uint256 k) public view returns (uint256 h) {
        assembly {
            let lastoutput := x
            let base := 0
            
            // For loop: for (uint256 i = 0; i < nRounds; i++)
            let i := 0
            
            // Loop condition: i < nRounds
            for { } lt(i, sload(nRounds.slot)) { 
                i := add(i, 1) 
            } {
                base := addmod(lastoutput, k, sload(p.slot))
                base := addmod(base, sload(add(c.slot, i)), sload(p.slot))
                
                // Apply power 5 by multiplying three times
                lastoutput := mulmod(base, base, sload(p.slot))
                lastoutput := mulmod(lastoutput, lastoutput, sload(p.slot))
                lastoutput := mulmod(lastoutput, base, sload(p.slot))
            }

            h := addmod(lastoutput, k, sload(p.slot))
        }
    }
}
