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
];

function generateKeywordCombinations(keywords) {
  const result = [];

  for (let i = 0; i < keywords.length; i++) {
    for (let j = i + 1; j < keywords.length; j++) {
      result.push(`${keywords[i]} ${keywords[j]}`);
      result.push(`${keywords[j]} ${keywords[i]}`);
    }
  }

  for (let i = 0; i < keywords.length; i++) {
    result.push(keywords[i]);
  }

  return result;
}

const KEYWORD_COMBINATIONS = generateKeywordCombinations(KEYWORDS).join('|');

const PRODUCT_IDS = [
    "SL1",
    "CH1",
    "DO1",
    "MC1",
    "MB1",
    "DO2",
].join('|');

const PRODUCT_NAMES = [
    "Dior Poison"
].join("|");

// Screen
const mainScreen = visual(state => state.screen === "main");
const searchScreen = visual(state => state.screen === "search");
const viewProductScreen = visual(state => state.screen === "view_product");
const checkoutScreen = visual(state => state.screen === "checkout");

function isScreen(screen) {
    visual(state => console.log(state.screen));
    return visual(state => state.screen === screen);
}

// Search product
// intent(
//     '(I would like to view|Search) (for|) $(PRODUCT)',
//     p => {
//         p.play({command:'navigation', route: '/search', data: p});
//         p.play(`Here is your search result of ${p.PRODUCT.value}.`);
//     }
// )

intent(`Get Started`, p => {
    p.play({command: 'getStarted'});
});

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
    `Search (for|) $(P ${KEYWORD_COMBINATIONS})`,
    p => {
        p.play({
            command:'navigation', 
            route: '/search',  
            data: p.P.value, 
        });
        p.play(`Here is the search result of ${p.P}`);
    }
);

intent(
    `(I want to|) (See|Check|View) $(P ${PRODUCT_NAMES})`,
    p => {
        p.play({
            command:'navigation', 
            route: '/product', 
            data: p.P.value, 
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
//         p.play(`Added to cart. Do you want to proceed to checkout page or continue shopping?`);
        p.play(`Successfully added to cart.`);
    }
)

intent(
    isScreen('view_product'),
    `Buy now`,
    p => {
        p.play({
            command: 'buyNow',
        });
        p.play(`Going to checkout page`);
    }
)

intent(
    `(Continue|) (checkout|check out)`,
    p => {
        p.play({
            command: 'navigation',
            route: '/addAddress',
        });
        p.play(`You need to fill in your shipping address to proceed checkout`);
    }
)

intent(
    isScreen('address') || isScreen('checkout'),
    `(Confirm|Go to|) payment`,
    p => {
        p.play({
            command: 'navigation',
            route: '/payment',
        });
        p.play(`Processing Payment`);
    }
)