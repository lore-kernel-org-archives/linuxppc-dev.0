Message-ID: <B0000680831@icamail.ica.net>
Subject: Re: AWACS Bug
Date: Thu, 28 Jan 99 15:03:31 -0400
From: Trevor Woerner <twoerner@ica.net>
To: "Russell Hires" <inet2@akos.net>,
        "LinuxPPC Developer" <linuxppc-dev@lists.linuxppc.org>,
        "LinuxPPC Users" <linuxppc-user@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Russell,

>it happens when I try to backspace too much
>at the prompt, or lately when I try to come out of X (using AfterStep)
>back into the shell...I tried the user support list, and they suggested
>that I ask the developers if they knew anything. So,
>Do you know of what could be causing this, or how I should try to fix
>it?

this is REALLY off the top of my head and just a suggestion. i have
no idea how the kernel works, or how the sound works, or how the kernel
interracts with the sound, so i have no clue how/if this'll work.

anyway, when you're in X why don't you try a:

    user# xset b off

(where "user#" is your prompt). i don't like a computer that beeps
and boops at me so i put this in my .xinitrc (or was it my .fvwm2rc?)
anyway, instead of beeping the console will flash (i.e. no beep)

xset takes a number of parameters (one of which is required to get the
mouse to track at a decent rate) to allow you to adjust a number of
things about your environment. on of the things you can change is the
bell setting. the command above turns the bell off.

give it a whirl, tell us what happens!

best regards,
    trevor woerner


------------------------------------------------------------

...and now, ladies and gentelmen, for your entertainment
   the band will play "Somewhere My Love Lies Sleeping"
   with a male chorus...

                             --- Groucho Marx


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
