if [ -z "$1" ];
    then
    # Ottieni l'input dall'utente
        echo "Inserisci il nome che vuoi dare alla soluzione"
        read parametro
        if [[ -z "$parametro" ]]; then
            echo "Errore: nessun parametro fornito."
            exit 1
        fi
else
    parametro=$1
fi
