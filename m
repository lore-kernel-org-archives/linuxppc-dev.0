Message-Id: <m0zsV1o-001C7HC@shell.rmi.net>
From: tph@rmi.net (Tom Harrington)
Subject: Re: TurboMouse fix
To: jacobs@azstarnet.com (john s jacobs anderson)
Date: Tue, 22 Dec 1998 09:51:23 -0700 (MST)
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.981221225654.1012A-100000@lazarus> from "john s jacobs anderson" at Dec 21, 98 11:03:14 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> system: 7500 chasis with 166 MHz 604 card, 2.1.127 kernel. Kensington
> TurboMouse 4.0 (the 2 button kind), window maker 0.20.3
> 
> (do you need to know anything else? sorry, I'm still a wet behind the
> ears...)
> 
> exported mail to ~, trimmed file in pico, then `cc mousehack.c`.
> 
> gives :
> /tmp/cca082751.o: In function `sethandler':
> /tmp/cca082751.o(.text+0x148): undefined reference to `ADB-WRITEREG'
> (same error repeated at (.text+0x1dc) in function `moveadb'
>                         (.text+0x26c) in function `initreg2'
>                         (.text+0x364) in function `setreg2'
> collect2: ld returned 1 exit status
> 
> ack! what now? I'm drooling at the thought of a functional 2 button mouse,
> and if it only ends up working with v5.0 TurboMice, Santa might have to
> make a late delivery...

Hmm, maybe something in your header files?  ADB_WRITEREG is defined (on
my system) in /usr/include/asm/adb_mouse.h.  Look for this file and see 
what's there.

I'm surprised it complains about "ADB-WRITEREG" when the code uses
"ADB_WRITEREG".  You didn't happen to "fix" this while trimming the
file in pico, did you?

I really don't know if mousehack is useful (or even necessary) with a v4.0
TurboMouse.  I assume you've tried the "mousemode" command?

Tom


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
