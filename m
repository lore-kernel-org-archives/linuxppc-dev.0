Message-Id: <199812131040.LAA03780@piglet.cpu.lu>
Date: Sun, 13 Dec 1998 11:40:28 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: matroxfb, anybody?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Anybody successfull in running matroxfb with recent vger kernels?

I've tried using it alongside controlfb as a second framebuffer, but it
doesn't initialize. Compiled-in, it only goes through the very first
debugging message, and then nothing more;  while as a module insmod
aborts (slightly older matroxfb.c (1.6c)) or hangs the system (most
recent matroxfb.c (1.8)).

I've also tried to compile-in matroxfb without controlfb, but that
failed because offb.c wasn't in (undefined ref to console_getmode et
al.). I'm right now trying a recompile with OF support compiled in, but
no framebuffer driver. Let's see....

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
9, Montee St. Crepin           |    Ask Questions.  Make Mistakes.
L-1365 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
