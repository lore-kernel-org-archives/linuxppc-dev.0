Message-Id: <200009140546.HAA00808@piglet.grunz.lu>
Date: Thu, 14 Sep 2000 07:46:45 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39BFFEA5.FE89C6EC@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  14 Sep, this message from Martin Costabel echoed through cyberspace:
>> Anyway, here it is for both 2.2 and 2.4. Note that to compile on 2.2,
>> you need my controlfb patch implementing mmap as well, since without it,
>> this one won't compile (get it on sourceforge).
>
> Tried it for valkyriefb: Doesn't work. It works in console mode, where
> it actually feels like it is scrolling fast, but starting X gives an
> immediate system freeze. I tried it twice, but now I'll go to bed.

Sh....

>> Have fun!
>
> Not much fun in hard rebooting and watching 15 minutes of fsck.

Sorry about that.... hope you slept well nevertheless ;-)

Can you have a look and see what might be wrong? Ill do the same,
hopefully tonight, but no guarantee...

A quick look shows that valkyrie has a single memory region, with the
framebuffer, the registers and the colormap all within the same region.
That might blow up the logic within valkyrie_mmap() to defferentiate between
framebuffer and mmio.

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
