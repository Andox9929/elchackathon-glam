// {Name: Ecommerce Script}
// {Description: Ecommerce app basic command.}

title('Ecommerce Command')

/* const products = {
    "lipstick": [
        {
            id: "loreal_lipstick_red", 
            name: "Color Riche Lipstick Matte Red", 
            price: 15.00, 
            keywords: ["lipstick", "red"],
            description: "Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.", 
            brand: "L'Oréal"
        },
        {
            id: "el_lipstick_red",
            name: "Estee Lauder Red Lipstick", 
            price: 30.00, 
            keywords: ["lipstick", "red"],
            description: "A Red Lipstick from Estee Lauder", 
            brand: 'Estee Lauder',
            image: 'el_lipstick_red.jpg',
        },
        {
            id: "loreal_lipstick_cherry", 
            name: "Color Riche Lipstick Matte Cherry", 
            price: 15.00, 
            keywords: ["lipstick", "cherry"],
            description: "Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.", 
            brand: "L'Oréal"
        },
        {
            id: "es_lipstick_pink",
            name: "Estee Lauder Pink Lipstick", 
            price: 30.00,
            keywords: ["lipstick", "pink"],
            description: "A Pink Lipstick from Estee Lauder", 
            brand: 'Estee Lauder',
            image: 'el_lipstick_pink.jpg',
        },
    ],
    "eyeshadow": [
        {
            id: "es_pure_color_envy", 
            name: "Pure Color Envy", 
            price: 70.90, 
            description: "The ultimate dimension for eyes that mesmerize. Shades you love, now in limited edition quads curated for intuitive application and eye-opening effects.",
            brand: "Estee Lauder"
        },
        {
            id: "loreal_eyeshadow", 
            name: "La Petite Palette Eyeshadow", 
            price: 79.90, 
            description: "A Red Lipstick from Estee Lauder",
            brand: "L'Oréal"
        },
    ],
}; */

// const PRODUCT_CAT = Object.keys(products).join("|");
// const PRODUCT = Object.values(products).flat().map(product => product.name).join("|");
// const BRAND = [... new Set(Object.values(products).flat().map(product => product.brand))].join("|");

const KEYWORDS = [
    "lipstick",
    "red",
    "purple",
    "pigment",
].join('|');

const PRODUCT_IDS = [
    "SL1",
    "CH1",
    "DO1",
    "MC1",
    "MB1",
    "DO2",
];

// Search product
// intent(
//     '(I would like to view|Search) (for|) $(PRODUCT)',
//     p => {
//         p.play({command:'navigation', route: '/search', data: p});
//         p.play(`Here is your search result of ${p.PRODUCT.value}.`);
//     }
// )

intent(`(Open|Go to) cart`, p => {
    p.play({
        command: 'navigation',
        route: '/cart'
    });
    p.play(`Here is your cart`);
});

intent(
    `Proceed to checkout page`,
    p => {
        p.play({
            command: 'navigation',
            route: '/cart',
        });
        p.play(`Here is your checkout page`);
    }
)

intent(`(Open|Go to|Back to) (home|homepage|main page)`, p => {
    p.play({
        command: 'navigation',
        route: '/home'
    });
    p.play(`(This is your homepage|Here you go)`);
});

intent(
    `Search for $(P ${KEYWORDS})`,
    p => {
        let selectedProducts = products[p.P.value.toLowerCase()];
        p.play({
            command: 'navigation',
            route: '/search',
            data: p.P.value,
            products: JSON.stringify(selectedProducts)
        });
        p.play(`Here is the search result of ${p.P}`);
    }
);

intent(
    `(I want to|) (See|Check) $(P ${PRODUCT_IDS})`,
    p => {
        p.play({
            command: 'navigation',
            route: '/product',
            data: p.P.value(),
        });
        p.play(`Here you go ${p.P}`);
    }
);

intent(
    `Add $(P ${PRODUCT_IDS}) to cart`,
    p => {
        p.play({
            command: 'addToCart',
            data: p.P.value(),
        });
        p.play(`Added to cart.`);
    }
)

intent(
    `Buy now`,
    p => {
        p.play({
            command: 'buyNow',
        });
        p.play(`Going to checkout page`);
    }
)

intent(
    `(Continue|) checkout`,
    p => {
        p.play({
            command: 'navigation',
            route: '/addAddress',
        });
        p.play(`You need to fill in your shipping address to proceed checkout`);
    }
)

intent(
    `(Confirm|Go to|) payment`,
    p => {
        p.play({
            command: 'navigation',
            route: '/payment',
        });
        p.play(`Processing Payment`);
    }
)