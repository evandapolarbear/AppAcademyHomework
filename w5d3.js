function madLib(verb, adjective, noun){
  console.log('We shall ${verb} the ${adjective} ${noun}');
}

madLib("make", "best", "guac");

function subString(search, sub) {
  search = search.spilt(" ");
  search.include(sub);
}

subString("hello its me", 'hello');

function fizzBuzz(arr) {
  let newArr = [];
  for (let i = 0; i < arr.length; i++){
    if (arr[i] % 3 === 0 || arr[i] % 5 === 0) {
      newArr.push(arr[i]);
    }
  }
  return newArr;
}

function isPrime(num) {
  for(let i = 2; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return true;
}
