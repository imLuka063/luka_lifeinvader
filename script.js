// Lifeinvader öffnen/schließen
window.addEventListener('message', function (event) {
    const data = event.data;

    if (data.action === "openLife") {
        document.getElementById("life-container").style.display = "block";
    }

    if (data.action === "closeLife") {
        document.getElementById("life-container").style.display = "none";
    }

    if (data.type === "showAnnounce") {
        showAnnounce(data.message);
    }
});

// ESC Taste -> Menü schließen
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        });
    }
});

// Neue Anzeige absenden
document.getElementById("btn-anzeige-senden").addEventListener('click', function() {
    const text = document.querySelector(".search_bar").value.trim();
    const isAnonym = document.getElementById("anzeige-anonym").checked;
    let playerName = isAnonym ? "Anonym" : "Spieler";

    if (text === "") {
        fetch(`https://${GetParentResourceName()}/leer`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        });
        return;
    }

    if (text.length > 100) {
        fetch(`https://${GetParentResourceName()}/over100`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({})
        });
        return;
    }

    // Nachricht als Announce an Server schicken
    fetch(`https://${GetParentResourceName()}/announce`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({
            player: playerName,
            message: text,
            isAnonym: isAnonym
        })
    });

    // Eingabeformular leeren
    document.getElementById("neue-anzeige-text").value = '';
    document.getElementById("anzeige-anonym").checked = false;
});

// Funktion zum Anzeigen der Ankündigung (announce)
function showAnnounce(message) {
    const announceContainer = document.getElementById('announce-container');
    const announceText = document.getElementById('announce-text');

    announceText.textContent = message;
    announceContainer.style.display = 'flex';

    setTimeout(() => {
        announceContainer.style.display = 'none';
    }, 10000);
}
