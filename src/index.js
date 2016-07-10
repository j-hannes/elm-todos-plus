// pull in desired CSS/SASS files
require('./styles/main.scss');

var Elm = require('./App/Main');
Elm.App.Main.embed(document.getElementById('main'));
