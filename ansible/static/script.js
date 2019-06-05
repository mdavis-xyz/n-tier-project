// window.addEventListener("load",function() {alert('script loaded')},false);
function fetchData(){
   console.log("fetching data")
   fetch('./dynamic', {
     method: 'GET'
   })
   .then(function(response) { 
      console.log("Received data, parsing json now");
      return response.json(); })
   .then(function(json) {
     // use the json
     console.log("prased json");
     console.log(json);
     console.log("applying to DOM");
     var cardContainer = document.getElementById("cards");
     deleteChildren(cardContainer)
     json.forEach(function(data){
        // data is {'firstName':'something','lastName':'something'}
        var card = document.createElement("article");
        card.classList.add("card");
        card.classList.add("appear");

        var firstName = document.createElement("span")
        firstName.innerHTML = data['firstName'];
        firstName.classList.add("firstName");
        card.append(firstName)

        card.append(" ");
        
        var lastName = document.createElement("span")
        lastName.innerHTML = data['lastName'];
        lastName.classList.add("lastName");
        card.append(lastName)

        cardContainer.append(card);
     })
   });
}


function deleteChildren(node){
   while (node.firstChild) {
          node.removeChild(node.firstChild);
   }
}
