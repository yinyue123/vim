# Add following code at the end of ~/.bashrc

# Check if ~/.pid_ssh_agent exists.
if [ -f ~/.pid_ssh_agent ]; then

    source ~/.pid_ssh_agent

    # Check process of ssh-agent still exists.
    TEST=$(ssh-add -l)

    if [ -z "$TEST" ]; then # Reinit if not.
        NEED_INIT=1
    fi
else
    NEED_INIT=1 # PID file doesm't exist, reinit it.
fi

# Try start ssh-agent.
if [ ! -z "$NEED_INIT" ]; then
    echo $(ssh-agent -s) | sed -e 's/echo[ A-Za-z0-9]*;//g' > ~/.pid_ssh_agent # save the PID to file.
    source ~/.pid_ssh_agent
fi

