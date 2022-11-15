module.exports = {
    contractAddress: "0xe4a9d807747428c3b1135600ae750d56d7dd1766",
    piece: (color) => (`
        <svg width="44" height="44" viewBox="0 0 44 44" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g filter="url(#filter0_d_356_902)">
                <circle cx="24" cy="20" r="20" fill="${color}"/>
                <circle cx="24" cy="20" r="20" fill="url(#paint0_linear_356_902)"/>
                <circle cx="24" cy="20" r="17.0312" stroke="url(#paint1_linear_356_902)" stroke-opacity="0.4" stroke-width="5.9375" stroke-dasharray="0.31 2.5"/>
            </g>
            <g filter="url(#filter1_ii_356_902)">
                <circle cx="24" cy="20" r="14.0741" fill="black" fill-opacity="0.14"/>
            </g>
                <circle cx="24" cy="20" r="14.0741" fill="black" fill-opacity="0.14"/>
                <circle cx="24" cy="20" r="13.9178" stroke="black" stroke-opacity="0.15" stroke-width="0.3125"/>
                <circle cx="24" cy="20" r="19.6875" stroke="url(#paint2_linear_356_902)" stroke-opacity="0.2" stroke-width="0.625"/>
            <defs>
                <filter id="filter0_d_356_902" x="0.25" y="0" width="43.75" height="43.75" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                    <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="-2.5" dy="2.5"/>
                    <feGaussianBlur stdDeviation="0.625"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
                    <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_356_902"/>
                    <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_356_902" result="shape"/>
                </filter>
                <filter id="filter1_ii_356_902" x="8.6759" y="4.67593" width="30.6481" height="30.6481" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                    <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                    <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="-1.25" dy="1.25"/>
                    <feGaussianBlur stdDeviation="0.625"/>
                    <feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
                    <feBlend mode="normal" in2="shape" result="effect1_innerShadow_356_902"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="1.25" dy="-1.25"/>
                    <feGaussianBlur stdDeviation="0.625"/>
                    <feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
                    <feBlend mode="normal" in2="effect1_innerShadow_356_902" result="effect2_innerShadow_356_902"/>
                </filter>
                <linearGradient id="paint0_linear_356_902" x1="38.2593" y1="5.92593" x2="9.18518" y2="33.7037" gradientUnits="userSpaceOnUse">
                    <stop stop-color="${color}" stop-opacity="0.2"/>
                    <stop offset="1" stop-color="${color}" stop-opacity="0"/>
                </linearGradient>
                <linearGradient id="paint1_linear_356_902" x1="33.6296" y1="4.25926" x2="7.51852" y2="34.0741" gradientUnits="userSpaceOnUse">
                    <stop stop-opacity="0.38"/>
                    <stop offset="1" stop-opacity="0.36"/>
                </linearGradient>
                <linearGradient id="paint2_linear_356_902" x1="14.3704" y1="37.2222" x2="41.5926" y2="10" gradientUnits="userSpaceOnUse">
                    <stop/>
                    <stop offset="1" stop-color="${color}" stop-opacity="0.5"/>
                </linearGradient>
            </defs>
        </svg>
    `)
}