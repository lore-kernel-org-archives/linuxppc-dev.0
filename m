Date: Thu, 31 Dec 1998 12:24:12 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: temporary freeze with Debian init
Message-ID: <Pine.LNX.4.03.9812311219300.21390-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



In the early stage of the boot process, init seems to freeze for 15-20 seconds.
First it freezes, a few seconds later it dumps

    NET3: Unix domain sockets 0.16 for Linux NET3.038.

Freeze for some more seconds, and continue. This even happens when I boot in
emergency mode (-b), after entering the root password.

I'm using Debian. Kernel version is irrelevant, and it didn't happen with my
old red Hat setup.

Anyone with a clue?

Greetings,

			    Geert (who likes fast boot ups, since rebooting
				   development machines is an important aspect
				   of life)

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
