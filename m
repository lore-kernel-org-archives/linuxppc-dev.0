From: Tom Harrington <tph@rmi.net>
Message-Id: <199901251921.MAA05588@shell.rmi.net>
Subject: Re: mac-on-linux project status
To: samuel@ibrium.se (Samuel Rydh)
Date: Mon, 25 Jan 1999 12:21:19 -0700 (MST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v03130305b2d231353f9c@[192.168.0.1]> from "Samuel Rydh" at Jan 25, 99 04:12:52 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Just out of curiosity, have you considered using PSIM?  It sounds like
> >it's a pretty complete PowerPC emulator.
> ><ftp://cambridge.cygnus.com/pub/psim/index.html>.
> 
> The idea is to run things natively on the processor. For instance, all
> user level instructions are run at full speed. The only thing needed
> to be emulated are the priviliged instructions. Since priviliged
> instructions only are used by the operating system for such things
> as interrupt control, mac-on-linux runs at in principle 100% speed.

I see.  You might want to rephrase some things on your web page then.
The page says:

"The mac-on-linux project does not utilize an emulation library. Instead 
it emulates the hardware of the machine. "

and 
"As stated above, all hardware must be emulated. "

and
"The processor emulation is fairly complete, with some exceptions:"

Now maybe it's just me, but "processor emulation" sounds just like PSIM.
It sounds like your approach is better, but your web page is confusing
on this point.  Emulating the whole processor and emulating priveliged
instructions only are two very different things.

Tom


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
