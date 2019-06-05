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
        // data is {'first_name':'something','last_name':'something'}
        var card = document.createElement("article");
        card.classList.add("card");
        card.classList.add("appear");

        var name_el = document.createElement('p');
	card.append(name_el);

        var first_name = document.createElement("span")
        first_name.innerHTML = data['first_name'];
        first_name.classList.add("first_name");
        name_el.append(first_name)

        name_el.append(" ");
        
        var last_name = document.createElement("span")
        last_name.innerHTML = data['last_name'];
        last_name.classList.add("last_name");
        name_el.append(last_name)

	var title = document.createElement('p');
	title.innerHTML = data['job_title'];
	title.classList.add('job_title');
	card.append(title);

        cardContainer.append(card);
     })
   });
}


function deleteChildren(node){
   while (node.firstChild) {
          node.removeChild(node.firstChild);
   }
}
