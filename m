Message-ID: <3BAA0E6F.5050503@mc.com>
Date: Thu, 20 Sep 2001 11:42:39 -0400
From: Mark Salisbury <mbs@mc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc LE questions (seeking help hand info pointers)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am familiar with the fact that little endian ppc linux is an unpopular
concept, but I would like to discuss it and ask a few questions about it
anyway. I do _NOT_ want to start a flame war, so if you feel the need to
flame me for this, pleas flame me directly offline and do not pollute
the list.


assume I have a valid reason for wanting to run ppc's in LE mode

assume I already have a (non-linux) ppc OS running LE mode (actually
compiles and runs in either mode, which you run depends on which flavor
of our hardware you use)  the differences in the code are limited to a
few header files, some startup code and some context switch code.
(to get an idea of the hardware see www.mc.com)

assume I am also aware of the limitations of the chip in LE mode, and
the intended target is 7400+ processors

question 1.  are there already existing patch sets (rejected from
mainline inclusion) available for use as a starting point?

question 2.  if 1, what is the primary reason for rejection.

question 3.  is there a general issue of endian safety in linux (I would
think not) or just in the ppc-specific code?

question 4. assuming I was willing to deliver a clean, complete LE
enabling patch (including devices that are relevant to me), as a compile
time config option and maintain that patch, what would be the primary
obstacle to inclusion in the main line.

thanks for your time,

		Mark

--
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------*/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
