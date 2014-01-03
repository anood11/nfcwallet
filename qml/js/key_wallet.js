function get_items()
{
    modelItems.clear();
    var text = storage.get_items();
    var jsonObject = eval('(' + text + ')');
    for (var index in jsonObject)
    {
        console.log(jsonObject[index].name)
        modelItems.append({
                              "md5id" : jsonObject[index].md5id,
                         "title" : jsonObject[index].title,
                          "url" : jsonObject[index].url,
                         "login" : jsonObject[index].user,
                         "password" : jsonObject[index].password,
                         "category" : jsonObject[index].category
                         });
    }
}

function get_categorys()
{
    modelCategorys.clear();
    var text = storage.get_categorys();
    var jsonObject = eval('(' + text + ')');
    for (var index in jsonObject)
    {
        modelCategorys.append({
                         "title" : jsonObject[index].name
                         });
    }
}


/** FIXME
function sync2server(site, uuid, group_uuid, site, title, user_name, password)
{
    var xhr = new XMLHttpRequest();

    var params = JSON.stringify({uuid: uuid, group_uuid: group_uuid, site: site, title: title, user_name: user_name, password: password})
    console.log(params)
    xhr.open("POST", site+"/nfckeywallet/items/api/items.json",true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");


    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                console.log(xhr.responseText)
            }
        }
    }
    xhr.send(params);

}

*/
