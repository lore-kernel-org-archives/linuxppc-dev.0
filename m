Date: Mon, 21 Dec 1998 23:03:14 -0700 (MST)
From: john s jacobs anderson <jacobs@azstarnet.com>
To: Tom Harrington <tph@rmi.net>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: TurboMouse fix
In-Reply-To: <m0zsJFT-001C3VC@shell.rmi.net>
Message-ID: <Pine.LNX.3.96.981221225654.1012A-100000@lazarus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've updated Mark Abene's "mousehack" fix for the Kensington Turbo Mouse
> to work with newer kernels.  The source code is below.

<snip>

> This has only been tested on a G3 desktop, running 2.1.125, with a
> version 5.0 TurboMouse.  I'd appreciate feedback on how it works
> (or fails to work) with other setups.

system: 7500 chasis with 166 MHz 604 card, 2.1.127 kernel. Kensington
TurboMouse 4.0 (the 2 button kind), window maker 0.20.3

(do you need to know anything else? sorry, I'm still a wet behind the
ears...)

exported mail to ~, trimmed file in pico, then `cc mousehack.c`.

gives :
/tmp/cca082751.o: In function `sethandler':
/tmp/cca082751.o(.text+0x148): undefined reference to `ADB-WRITEREG'
(same error repeated at (.text+0x1dc) in function `moveadb'
                        (.text+0x26c) in function `initreg2'
                        (.text+0x364) in function `setreg2'
collect2: ld returned 1 exit status

ack! what now? I'm drooling at the thought of a functional 2 button mouse,
and if it only ends up working with v5.0 TurboMice, Santa might have to
make a late delivery...

john.
jacobs@treefort.org
www.treefort.org/~jacobs/       <--- LinuxPPC notes'n'stuff... 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
