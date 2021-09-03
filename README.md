# Liberator Example

[![builds.sr.ht status](https://builds.sr.ht/~cosmicrose/liberator_example.svg)](https://builds.sr.ht/~cosmicrose/liberator?)

This library demonstrates how to use the [Liberator] library to create controllers that respect the HTTP specificiation.

[Liberator]: https://sr.ht/~cosmicrose/liberator

Check out the file at
[`lib\liberator_example_web\controllers\post_controller.ex`](https://git.sr.ht/~cosmicrose/liberator_example/tree/main/item/lib/liberator_example_web/controllers/post_controller.ex)
for an example of a controller using Liberator to pass Phoenix's generated controller tests.

## How it was made

This project was built using Phoenix generators.
First, a new Phoenix project was created.

```sh
mix phx.new liberator_example --no-webpack --no-html
```

Then, in that project, we generated the `LiberatorExample.Blog` context, with a `LiberatorExample.Blog.Post` object.
This generates a controller and an associated test module.

```sh
mix phx.gen.context Blog Post posts title:string content:string
```

We also added the associated `resources` directive to `LiberatorExampleWeb.Router`.

```elixir
scope "/api", LiberatorExampleWeb do
  pipe_through :api

  # You can use `Phoenix.Router.resources/4` with a Liberator resource.
  resources "/posts", PostController, except: [:new, :edit]
end
```

However, we then deleted the contents of [`LiberatorExampleWeb.PostController`] and replaced with a Liberator resource module.
Just enough functionality was added to the resource module to make [the existing controller tests] pass.

[`LiberatorExampleWeb.PostController`]: https://git.sr.ht/~cosmicrose/liberator_example/tree/main/item/lib/liberator_example_web/controllers/post_controller.ex
[the existing controller tests]: https://git.sr.ht/~cosmicrose/liberator_example/tree/main/item/test/liberator_example_web/controllers/post_controller_test.exs

## Contributing

Questions and pull requests are more than welcome.
I follow Elixir's tenet of bad documentation being a bug,
so if anything is unclear, please let me know in our [mailing list](https://lists.sr.ht/~cosmicrose/liberator)!
Ideally, my answer to your question will be in an update to the docs.

## License

MIT License

Copyright 2021 Rosa Richter

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
