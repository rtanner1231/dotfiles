alias cdeploy='echo "<deploy><files>" > deploy.xml; git diff --name-only origin/master.. | grep "^FileCabinet" | sed -e "s/^/<path>~\//g" -e "s/$/<\/path>/g" >> deploy.xml; echo "</files></deploy>" >> deploy.xml'

alias lss='eza --long --git --no-permissions --no-user --group-directories-first --icons --no-time --no-filesize'
