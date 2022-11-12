module.exports = {
    contractAddress: "0xb0b2c3ad9f911b51276548ccb7071160cab0014a",
    piece: (color) => (`
        <svg width="45" height="44" viewBox="0 0 45 44" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="22.25" cy="22" r="20" fill="${color}" fill-opacity="0.6"/>
            <circle cx="22.25" cy="22" r="20.9556" stroke="${color}" stroke-opacity="0.6" stroke-width="1.91122" stroke-dasharray="1.91 1.91"/>
        </svg>
    `)
}