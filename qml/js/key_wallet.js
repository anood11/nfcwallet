function wallet_get()
{
    listModel.clear();
    var xhr = new XMLHttpRequest();
    xhr.open("GET","http://7b4.se/nfckeywallet/items/list",true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
//                console.log(xhr.responseText)
                loaded(jsonObject)
            }
        }
    }
    xhr.send();
    
}

function wallet_post(uuid, group_uuid, site, title, user_name, password)
{
    var xhr = new XMLHttpRequest();

    var params = JSON.stringify({uuid: uuid, group_uuid: group_uuid, site: site, title: title, user_name: user_name, password: password})
    console.log(params)
    xhr.open("POST","http://7b4.se/nfckeywallet/items/api/items.json",true);
    xhr.setRequestHeader("Content-type", "application/json");
    xhr.setRequestHeader("Content-length", params.length);
    xhr.setRequestHeader("Connection", "close");


    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
//                var jsonObject = eval('(' + xhr.responseText + ')');
                console.log(xhr.responseText)
//                wallet_get();
//                loaded(jsonObject)
            }
        }
    }
    xhr.send(params);

}



function loaded(jsonObject)
{

    for ( var index in jsonObject  )
    {
        console.log(jsonObject[index].name)
        listModel.append({
                         "uuid" : jsonObject[index].uuid,
                         "title" : jsonObject[index].title,
                         "login" : jsonObject[index].user_name,
                         "password" : jsonObject[index].password,
                         });
    }



/*
    listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.icabanken.se", "uuid" : nfc.generateUUID(), "name" : "Ica kort","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Bank", "deleted" : false })
    listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.coop.se", "uuid" : nfc.generateUUID(), "name" : "Coop Kort","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Bank", "deleted" : false })
    listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.facebook.com", "uuid" : nfc.generateUUID(), "name" : "Facebook","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
    listModel.append({"iconUrl" : "http://twitter.com/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Twitter","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
    listModel.append({"iconUrl" : "http://ssl.gstatic.com/s2/oz/images/faviconr3.ico", "uuid" : nfc.generateUUID(), "name" : "Google+","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
    listModel.append({"iconUrl" : "http://talk.maemo.org/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Maemo","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Linux community", "deleted" : false })
    listModel.append({"iconUrl" : "http://merproject.org/images/mer-logo.png", "uuid" : nfc.generateUUID(), "name" : "Merproject","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Linux community", "deleted" : false })
    listModel.append({"iconUrl" : "http://www.jolla.com/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Jolla","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Companys", "deleted" : false })
*/
}
