function load_article(name){
	console.log("load article");
	$.get("article/"+name,"",function(data){
		$('#output').html(data);
		console.log("loaded article");
	});
};

