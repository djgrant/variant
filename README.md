# Variant

Although there are many tools to set up and analyse split tests, none provide a methodology for serving rubustly implementing user interface variants.

Typically services manipulate the DOM after the page has loaded, circumventing proper practises for interface development. Building split tests in this way limits the scope of what can be achieved in a variant, can be difficult to implement (as building any interface just using overrides always is), can cause problems with responsive layouts and can cause problems with internationalisation.

Furthermore, the approach is very dangerous as removing or modifying DOM elements lead to errors and functionality breaking.

In conclusion, it is always advisable to serve variants for split tests through your typical software development workflow.

## Building robust a/b tests

For major a/b tests we can use the `variant()` mixin, which allows you to create complicated split tests with very readable code by separating the styles for different variants into separate stylesheets.

## Setting up a variant

1) Create stylesheets for each variant in `stylesheets/variants/`.

For example if we wanted to test a variant which adds animations when adding items to the cart we could create a stylesheet called `above-the-fold.sass`, assign the name of the varaint to the variable `$variant` and include the main stylesheet.

```
$variant: "above-the-fold"
@import "../main/main"
```


2) Use a split testing framework to serve the control or variant stylesheets:

```
<% ab_test("purchase_flow", "go_to_basket", "skip_basket") do |test| %>
  <% stylesheet = test == "control" ? "eagle/stylesheets/main/main" : "eagle/stylesheets/variants/skip-basket" %>
  <%= stylesheet_link_tag stylesheet, :media => 'screen' %>
<% end %>
```

Example using [https://github.com/andrew/split](https://github.com/andrew/split)

## Creating a variant interface

You can now use the `variant()` mixin to funnel styles into the correct variant stylesheet and filter from the main (control) stylesheet:

```
+variant('above-the-fold')
  .module
    transition: 1s ease

```

The mixin can also be nested, which allows you to write very readable style blocks:

```
.module
  .module-inner
    width: 100%
    height: 20px

    +variant('above-the-fold')
      transition: 1s ease
```

`variant()` also accepts the argument `main` for cases where style declarations are to be only served to the main stylesheet:


```
.module
  .module-inner
    width: 100%
    height: 20px

    +variant('above-the-fold')
      transition: 1s ease

    +variant('main')
      background: green
```

Similarly, the mixin 'variant-not()' can be used to serve style declarations to all stylesheets (main and all variants) except the variant passed to the mixin:

```
.module
  +variant('above-the-fold')
    background: red

  +variant-not('above-the-fold')
    background: green
```

Both the `variant()` and `variant-not()` mixins accept multiple arguments allowing you to target, or exclude, multiple stylesheets at once:

```
.module
  +variant('above-the-fold', 'upsell-product')
    background: red

  +variant-not('above-the-fold', 'main')
    background: green
```
