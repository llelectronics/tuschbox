//db.js
.import QtQuick.LocalStorage 2.0 as LS

// First, let's create a short helper function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("tuschbox", "1.0", "StorageDatabase", 100000);
}

String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

// Path to qml Files
var qmlPath = "/usr/share/harbour-tuschbox/qml/pages/"

// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx,er) {
                    // Create the bookmarks table if it doesn't already exist
                    // If the table exists, this is skipped

                    //                    btnId: "tuschBtn",
                    //                           name: "Tusch",
                    //                           colour: "gray",
                    //                           bicon: "images/mask-icon.png",
                    //                           sound: "sounds/karneval/tusch.ogg",
                    //                           playing: false,
                    //                           set: "Kölner Karneval"

                    tx.executeSql('CREATE TABLE IF NOT EXISTS soundsets(btnId TEXT, name TEXT, colour TEXT, bicon TEXT, sound TEXT, playing TEXT, sset TEXT)');
                    var table  = tx.executeSql("SELECT * FROM soundsets");
                    // Insert template soundset if no soundsets are set / empty soundsets db
                    if (table.rows.length === 0) {
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn1", "Empty", "red", qmlPath + "images/mask-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn2", "Empty", "orange", qmlPath + "images/stars-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn3", "Empty", "yellow", qmlPath + "images/blumen-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn4", "Empty", "green", qmlPath + "images/trommel-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn5", "Empty", "blue", qmlPath + "images/heart-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn6", "Empty", "indigo", qmlPath + "images/konfetti-icon.png", "empty", "false", "temp"]);
                        tx.executeSql('INSERT INTO soundsets VALUES (?,?,?,?,?,?,?);', ["sBtn7", "Empty", "violet", qmlPath + "images/bye-icon.png", "empty", "false", "temp"]);
                    }
                });
}

// This function is used to write soundsets into the database
function addToSoundset(btnId,name,colour,bicon,sound,playing,sset) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        // Remove and readd if url already in bookmarks
        removeSoundset(btnId,sset);
        console.debug("Adding to soundset db:" + name + " " + sound + " in " + sset + " for button " + btnId);

        var rs = tx.executeSql('INSERT OR REPLACE INTO soundsets VALUES (?,?,?,?,?,?,?);', [btnId,name,colour,bicon,sound,playing,sset]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to remove a soundset from database
function removeSoundset(btnId,sset) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM soundsets WHERE btnId=(?) AND sset=(?);', [btnId,sset]);
        //        if (rs.rowsAffected > 0) {
        //            console.debug("Url found and removed");
        //        } else {
        //            console.debug("Url not found");
        //        }
    })
}
// This function is used to retrieve bookmarks from database
function getSounds(page,sset) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM soundsets WHERE sset=(?);', [sset]);
        if (rs.rowsAffected > 0) {
            console.debug("Found sset:" + sset)
            addSoundBtn(page,rs)
        } else {
            // If set not found add temp buttons from temp set
            console.debug("Set not found");
            var rsTemp = tx.executeSql('SELECT * FROM soundsets WHERE sset=(?);', ["temp"]);
            addSoundBtn(page,rsTemp);
        }
    })
}

function getSoundBoards(page) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT DISTINCT sset FROM soundsets;');
        for (var i = 0; i < rs.rows.length; i++) {
            page.addSoundBards(rs.rows.item(i).sset)
        }
    })
}

// Add SoundButton to the UI
function addSoundBtn(page,res) {
    for (var i = 0; i < res.rows.length; i++) {
        console.debug("Adding Button: " + res.rows.item(i).btnId,res.rows.item(i).name,res.rows.item(i).colour,res.rows.item(i).bicon,res.rows.item(i).sound,res.rows.item(i).playing,res.rows.item(i).sset)
        page.addSoundButton(res.rows.item(i).btnId,res.rows.item(i).name,res.rows.item(i).colour,res.rows.item(i).bicon,res.rows.item(i).sound,stringToBoolean(res.rows.item(i).playing),res.rows.item(i).sset);
    }
}

// TODO: Adapt everything below here ------------

// This function is used to write settings into the database
function addSetting(setting,value) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Setting written to database");
        } else {
            res = "Error";
            console.log ("Error writing setting to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

function stringToBoolean(str) {
    switch(str.toLowerCase()){
    case "true": case "yes": case "1": return true;
                             case "false": case "no": case "0": case null: return false;
                                                                default: return Boolean(string);
    }
}

// This function is used to retrieve settings from database
function getSettings() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM settings;');
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).setting == "minimumFontSize") mainWindow.minimumFontSize = parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "defaultFontSize") mainWindow.defaultFontSize = parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "defaultFixedFontSize") mainWindow.defaultFixedFontSize = parseInt(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "loadImages") mainWindow.loadImages = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "privateBrowsing") mainWindow.privateBrowsing = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "dnsPrefetch") mainWindow.dnsPrefetch = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "userAgent") mainWindow.userAgent = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "homepage") { mainWindow.siteURL = rs.rows.item(i).value ; mainWindow.homepage = rs.rows.item(i).value }
            else if (rs.rows.item(i).setting == "offlineWebApplicationCache") mainWindow.offlineWebApplicationCache = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "userAgentName") mainWindow.userAgentName = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "searchEngine") mainWindow.searchEngine = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "searchEngineName") mainWindow.searchEngineName = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "orientation") mainWindow.orient = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "vPlayerExternal") mainWindow.vPlayerExternal = stringToBoolean(rs.rows.item(i).value)
        }
    })
}

// This function is used to write history into the database
function addHistory(url) {
    var date = new Date();
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        // Remove and readd if url already in history
        var rs0 = tx.executeSql('delete from history where url=(?);',[url]);
        //        if (rs0.rowsAffected > 0) {
        //            console.debug("Url already found and removed to readd it");
        //        } else {
        //            console.debug("Url not found so add it newly");
        //        }

        var rs = tx.executeSql('INSERT OR REPLACE INTO history VALUES (?,?);', [date.getTime(),url]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.log ("Saved to database");
        } else {
            res = "Error";
            //console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

function searchHistory(searchTerm) {
    var db = getDatabase();
    db.transaction(function(tx) {
        // Search history first
        var rs = tx.executeSql("SELECT url FROM history WHERE url LIKE ?;", ["%" + searchTerm + "%"]);
        // Search bookmarks second
        var rs1 = tx.executeSql("SELECT url FROM bookmarks WHERE url LIKE ?;", ["%" + searchTerm + "%"]);

        //        if (rs.rowsAffected > 0) {
        //            console.debug("Successfully executed")
        //            console.debug(rs.rows.item(0).url)
        //        }
        //        else console.debug("Not working")
        var hisFound
        var r = /^((https?|file)\:)\/\/(.[^/]+)/;  // Did I mention before how I hate regex. It took my an hour to figure this out and make it work :P

        if (rs.rows.length > 0) {
            // Clear previous historySuggestions here
            mainWindow.historyModel.clear();
            page.suggestionView.model = mainWindow.historyModel
            // And show history suggestions
            page.suggestionView.visible = true;
            hisFound = true;
        }
        else { page.suggestionView.visible = false; hisFound = false }

        for (var i = 0; i < rs.rows.length; i++) {
            // Add to historySuggestions here
            try {
                if (! (historyModel.contains(rs.rows.item(i).url.match(r)[0]) && rs.rows.item(i).url.match(r)[0].indexOf(searchTerm) != -1)) mainWindow.historyModel.insert(0,{"url" : rs.rows.item(i).url.match(r)[0]});
            } catch(e) { continue }
            if (! (historyModel.contains(rs.rows.item(i).url) ) ) mainWindow.historyModel.append({"url" : rs.rows.item(i).url});
            //console.debug(rs.rows.item(i).url);
        }
        if (rs1.rows.length > 0) {
            // Show bookmarks suggestions
            if (page.suggestionView.visible == false) page.suggestionView.visible = true;
        }
        else if (hisFound != true) page.suggestionView.visible = false;
        for (var i = 0; i < rs1.rows.length; i++) {
            // Add to historySuggestions here
            if (! (historyModel.contains(rs1.rows.item(i).url.match(r)[0]) && rs1.rows.item(i).url.match(r)[0].indexOf(searchTerm) != -1)) mainWindow.historyModel.insert(0, {"url" : rs1.rows.item(i).url.match(r)[0]});
            if (! (historyModel.contains(rs1.rows.item(i).url) ) ) mainWindow.historyModel.append({"url" : rs1.rows.item(i).url});
            //console.debug(rs.rows.item(i).url);
        }
    }
    );
}

// This function is used to retrieve history from database
function getHistory() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM history ORDER BY history.uid DESC;');
        for (var i = 0; i < rs.rows.length; i++) {
            historyModel.append({"url" : rs.rows.item(i).url});
        }
    })
}

// This function is used to remove a bookmark from database
function removeHistory(url) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM history WHERE url=(?);', [url]);
        //        if (rs.rowsAffected > 0) {
        //            console.debug("Url found and removed");
        //        } else {
        //            console.debug("Url not found");
        //        }
    })
}

function clearTable(table) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql("DELETE FROM " + table);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Cleared database table " + table);
        } else {
            res = "Error";
            console.log ("Error clearing database table " + table);
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to write bookmarks into the database
function addSession(session,tab,url,sessionTabs) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        console.debug("Adding to sessions db:" + session + " " + url);

        var rs = tx.executeSql('INSERT OR REPLACE INTO sessions VALUES (?,?,?,?);', [session,tab,url,sessionTabs]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.log ("Saved to database");
        } else {
            res = "Error";
            //console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to retrieve bookmarks from database
function getSession(session) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM sessions WHERE session=(?)', [session]);
        mainWindow.tabModel.clear();
        mainWindow.pageStack.clear(); // Hopefully that does not fail :)
        for (var i = 0; i < rs.rows.length; i++) {
            if (i<rs.rows.item(0).sessionTabs) mainWindow.loadInNewTab(rs.rows.item(i).url)
            //console.debug("Get Bookmarks from db:" + rs.rows.item(i).title, rs.rows.item(i).url)
        }
    })
}
