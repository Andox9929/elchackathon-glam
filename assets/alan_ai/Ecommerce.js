// {Name: Ecommerce Script}
// {Description: Ecommerce app basic command.}

title('Ecommerce Command')

const products = {
    "lipstick": [
        {
            id: "loreal_lipstick_red", 
            name: "Color Riche Lipstick Matte Red", 
            price: 15.00, 
            description: "Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.", 
            brand: "L'Oréal"
        },
        {
            id: "el_lipstick_red",
            name: "Estee Lauder Lipstick Red", 
            price: 30.00, 
            description: "A Red Lipstick from Estee Lauder", 
            brand: 'Estee Lauder',
            image: 'el_lipstick_red.jpg',
        },
        {
            id: "loreal_lipstick_cherry", 
            name: "Color Riche Lipstick Matte Cherry", 
            price: 15.00, 
            description: "Indulge in a smooth, long-lasting formula. with 29 shades of matte lipsticks from color riche now in a new packaging.", 
            brand: "L'Oréal"
        },
        {
            id: "es_lipstick_pink",
            name: "Estee Lauder Lipstick Pink", 
            price: 30.00,
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
};

const PRODUCT_CAT = Object.keys(products).join("|");
const PRODUCT = Object.values(products).flat().map(product => product.name).join("|");
const BRAND = [... new Set(Object.values(products).flat().map(product => product.brand))].join("|");
// Search product
// intent(
//     '(I would like to view|Search) (for|) $(PRODUCT)',
//     p => {
//         p.play({command:'navigation', route: '/search', data: p});
//         p.play(`Here is your search result of ${p.PRODUCT.value}.`);
//     }
// )

intent(`(Open|Go to) cart`, p => {
    p.play({command: 'navigation', route: '/cart'});
    p.play(`Here is your cart`);
});

intent(`(Open|Go to|Back to) (home|homepage|main page)`, p => {
    p.play({command: 'navigation', route: '/home'});
    p.play(`(This is your homepage|Here you go)`);
});

intent(
    `Search for $(P ${PRODUCT_CAT})`,
    p => {
        let selectedProducts = products[p.P.value.toLowerCase()];
        p.play({
            command:'navigation', 
            route: '/search',  
            data: p.P.value, 
            products: JSON.stringify(selectedProducts)
        });
        p.play(`Here is the search result of ${p.P}`);
    }
);

intent(
    `(I want to|) (See|Check) $(P ${PRODUCT})`,
    p => {
        let selectedProduct = Object.values(products).flatMap(arr => arr).find(p1 => p1.name.toLowerCase() === p.P.value.toLowerCase());
        p.play({
            command:'navigation', 
            route: '/product', 
            data: p.P.value, 
            product: JSON.stringify(selectedProduct)
        });
        p.play(`Here is the search result of ${p.P}`);
    }
);

intent(
    `Start App`,
    p => {
        p.play({
            command:'startApp'
        });
        p.play('Hi I am Alan. What can I help you.');
    }
);