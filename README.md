# elm todos plus

Todo app written in Elm to teach myself some Elm.

<img src="/screenshot.png?raw=true" alt="Screenshot" title="Elm Todos Plus App" width="475">

## Description

Project is based on [elm-webpack-starter](https://github.com/moarwick/elm-webpack-starter).

### Todo

- [ ] Add more description
- [ ] Add screenshots

## Develop

### Install:
```
git clone https://github.com/moarwick/elm-webpack-starter
cd elm-webpack-starter
npm install
```

If you haven't done so yet, install Elm globally:
```
npm install -g elm
```

Install Elm's dependencies:
```
elm package install
```

### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/Main.elm`
* Browser will refresh automatically on any file changes..


### Build &amp; bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
* To publish the `/dist` folder to your own GitHub repo's `gh-pages`, commit any changes, then:
```
git subtree push --prefix dist origin gh-pages
open http://<your-github-account>.github.io/elm-todos-plus/
```
