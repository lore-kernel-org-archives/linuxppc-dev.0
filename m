Date: Thu, 11 Mar 1999 09:51:45 +1100
Message-Id: <199903102251.JAA08378@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: bh40@calva.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990310131908.030129@mail.mipsys.com> (message from Benjamin
	Herrenschmidt on Wed, 10 Mar 1999 13:19:08 +0100)
Subject: Re: ADB Reset
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990310131908.030129@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <bh40@calva.net> wrote:

> After the bus reset, the mouse must be re-initialised to handler 4. In
> fact, the whole device probing and init must be redone (mac_keyb.c). I'm
> working on a simple design that allow ADB peripherial drivers to register
> to the ADB core in order to be notified of bus resets. Stay tuned.

If we have two devices with the same default ID, they may get assigned
different IDs after re-probing.  Any ideas how to cope with that?

On my 3400, after a snooze, sometimes the adb bus has been reset and
sometimes it hasn't.  I haven't been able to discern any pattern,
e.g. it doesn't seem to depend on how long the machine is asleep for.
I believe that the power to the adb bus is supposed to stay on during
sleep, so I don't see why it's getting reset.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
