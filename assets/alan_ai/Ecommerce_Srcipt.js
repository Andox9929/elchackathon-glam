// {Name: Ecommerce Script}
// {Description: Ecommerce app basic command.}

title('Ecommerce Command')

// Search product
intent(
    'Search $(product)',
    p => {
        p.play({command:'navigation', route: 'search/${product}'})
    }
)
