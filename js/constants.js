module.exports = {
    contractAddress: "0xe464b2b132d0e8c191c11fd362afaadd99d58798",
    piece: (color, king) => (`
        <svg width="44" height="44" viewBox="0 0 525 525" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g filter="url(#filter0_d_359_466)">
                <circle cx="285" cy="240" r="240" fill="${color}"/>
                <circle cx="285" cy="240" r="240" fill="url(#paint0_linear_359_466)"/>
                <circle cx="285" cy="240" r="204.375" stroke="url(#paint1_linear_359_466)" stroke-opacity="0.4" stroke-width="71.25" stroke-dasharray="3.75 30"/>
            </g>
            <g filter="url(#filter1_ii_359_466)">
                <circle cx="285" cy="240" r="168.889" fill="black" fill-opacity="0.14"/>
            </g>
            <circle cx="285" cy="240" r="168.889" fill="black" fill-opacity="0.14"/>
            <circle cx="285" cy="240" r="167.014" stroke="black" stroke-opacity="0.15" stroke-width="3.75"/>
            <circle cx="285" cy="240" r="236.25" stroke="url(#paint2_linear_359_466)" stroke-opacity="0.2" stroke-width="7.5"/>
            ${king ? `<g filter="url(#filter2_d_359_466)">
                <path d="M378.75 183.5V292.42C378.75 294.491 377.071 296.17 375 296.17H195C192.929 296.17 191.25 294.491 191.25 292.42V183.446C191.25 179.874 195.772 178.325 197.962 181.146L241.597 237.355C243.254 239.489 246.555 239.224 247.85 236.853L279.729 178.498C281.148 175.901 284.875 175.894 286.304 178.486L320.139 239.884C321.442 242.249 324.743 242.503 326.392 240.364L372.031 181.209C374.217 178.376 378.75 179.922 378.75 183.5Z" fill="white"/>
                <path d="M378.75 183.5V292.42C378.75 294.491 377.071 296.17 375 296.17H195C192.929 296.17 191.25 294.491 191.25 292.42V183.446C191.25 179.874 195.772 178.325 197.962 181.146L241.597 237.355C243.254 239.489 246.555 239.224 247.85 236.853L279.729 178.498C281.148 175.901 284.875 175.894 286.304 178.486L320.139 239.884C321.442 242.249 324.743 242.503 326.392 240.364L372.031 181.209C374.217 178.376 378.75 179.922 378.75 183.5Z" fill="url(#paint3_linear_359_466)" fill-opacity="0.15"/>
                <path d="M380.625 292.42V183.5C380.625 178.133 373.825 175.814 370.546 180.064L324.908 239.219C324.083 240.288 322.433 240.161 321.781 238.979L287.946 177.581C285.803 173.693 280.212 173.703 278.083 177.599L246.205 235.955C245.557 237.14 243.906 237.272 243.078 236.205L199.443 179.997C196.157 175.764 189.375 178.087 189.375 183.446V292.42C189.375 295.527 191.893 298.045 195 298.045H375C378.107 298.045 380.625 295.527 380.625 292.42Z" stroke="black" stroke-opacity="0.15" stroke-width="3.75"/>
            </g>` : ``}
            <defs>
                <filter id="filter0_d_359_466" x="0" y="0" width="525" height="525" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                    <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="-30" dy="30"/>
                    <feGaussianBlur stdDeviation="7.5"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0"/>
                    <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_359_466"/>
                    <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_359_466" result="shape"/>
                </filter>
                <filter id="filter1_ii_359_466" x="101.111" y="56.1111" width="367.778" height="367.778" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                    <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                    <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="-15" dy="15"/>
                    <feGaussianBlur stdDeviation="7.5"/>
                    <feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.12 0"/>
                    <feBlend mode="normal" in2="shape" result="effect1_innerShadow_359_466"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="15" dy="-15"/>
                    <feGaussianBlur stdDeviation="7.5"/>
                    <feComposite in2="hardAlpha" operator="arithmetic" k2="-1" k3="1"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0.1 0"/>
                    <feBlend mode="normal" in2="effect1_innerShadow_359_466" result="effect2_innerShadow_359_466"/>
                </filter>
                <filter id="filter2_d_359_466" x="172.5" y="172.796" width="210" height="142.124" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                    <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                    <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                    <feOffset dx="-7.5" dy="7.5"/>
                    <feGaussianBlur stdDeviation="3.75"/>
                    <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
                    <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_359_466"/>
                    <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_359_466" result="shape"/>
                </filter>
                <linearGradient id="paint0_linear_359_466" x1="456.111" y1="71.1111" x2="107.222" y2="404.444" gradientUnits="userSpaceOnUse">
                    <stop stop-color="white" stop-opacity="0.2"/>
                    <stop offset="1" stop-color="white" stop-opacity="0"/>
                </linearGradient>
                <linearGradient id="paint1_linear_359_466" x1="400.556" y1="51.1111" x2="87.2223" y2="408.889" gradientUnits="userSpaceOnUse">
                    <stop stop-opacity="0.38"/>
                    <stop offset="1" stop-opacity="0.36"/>
                </linearGradient>
                <linearGradient id="paint2_linear_359_466" x1="169.444" y1="446.667" x2="496.111" y2="120" gradientUnits="userSpaceOnUse">
                    <stop/>
                    <stop offset="1" stop-color="white" stop-opacity="0.5"/>
                </linearGradient>
                <linearGradient id="paint3_linear_359_466" x1="290.984" y1="156.543" x2="203.218" y2="314.122" gradientUnits="userSpaceOnUse">
                    <stop stop-color="white"/>
                    <stop offset="1" stop-color="white" stop-opacity="0"/>
                </linearGradient>
            </defs>
        </svg>
    `)
}