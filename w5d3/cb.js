function myTimeOut (word) {
  setTimeout(() => console.log(word), 5000);
}

myTimeOut("hello");

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function teaTime() {
  let first, second;

  reader.question('would you like some tea?',
    (res) => first = res);

  reader.question('would you like some tea?',
    (res) => {second = res
      return `${first} you want tea, and ${second} you want biscuts`;
    }
  );

}

function Cat () {
  this.name = 'Markov';
  this.age = 3;
}

function Dog () {
  this.name = 'Noodles';
  this.age = 4;
}

Dog.prototype.chase = function (cat) {
  console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`)
};

const Pico = new Cat ();
const Levi = new Do ();

Levi.chase.call(Pico, Levi);
Levi.chase.apply(Pico, [Levi]);
