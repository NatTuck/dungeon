import socket from "./socket";

export var start = function(link_id) {
    let channel = socket.channel(`links:${link_id}`, {});
    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) });
    
    $('#click-me').on("click", () => {
        channel.push("heya", 1)
    });

    $(document).keypress(evt => {
        console.log("keypress: ", evt);
    });

    channel.on("show", payload => {
        $('#game-content').html(payload['game_html']);
        console.log(payload);
    });

    channel.on("goats", msg => {
        console.log("goats", msg);
    });
};

