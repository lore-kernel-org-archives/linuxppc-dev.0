Message-Id: <200008082046.WAA04603@piglet.grunz.lu>
Date: Tue, 8 Aug 2000 22:46:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: quik/kernel interaction
To: hispeed@phlo.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <398E11CA.A95426B8@phlo.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Bill,

On   6 Aug, this message from Bill Jackson echoed through cyberspace:
> i have tried to upgrade my kernel from 2.2.15 to 2.2.17(test 5 and benh)
> or 2.4.0.  I am able to get the kernels to compile, but they won't
> boot.  I have modified my quik.conf file and reran quik.  with any of
> the new kernels I have made (I also made the existing 2.2.15 kernel), i
> get the quik boot screen and select the kernel I wish to boot and the
> screen goes to the "copying OF device tree....done", then says
> 'booting', but then it locks up.  i never get the actual  kernel to
> load....at one point, i was getting a returning from prom_init message,
> but I no longer get that message.  I also at one point got messages
> "Initializing Fake screen" and "Failed to get address", followed by a
> "returning from prom_init" message...but the kernel never actually
> loads...

Occasionally, I had the same problem, but it was relatively random. It
could happen on one kernel, I would recompile it, and the problem would
be gone. Or I switched the box off for some time, retried, and now it
worked...

I would rather conclude on some strange phenomenon rather than a
straight bug somewhere. Possibly recent kernels, due to some code
changes like differences in execution time, reveal the problem more
often....

Unfortunately, I don't have a solution neither.... Note that I'm running
aome old version of quik that I had to modifiy to get it to boot my G3
processor upgrade card. There was a problem with the way the BAT regs
were set... No idea whether the fix Paulus sent me actually made its way
into the latest quik release.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
