// pull in desired CSS/SASS files
require('./styles/main.scss');

var Elm = require('./elm/App');
Elm.App.embed(document.getElementById('main'));
