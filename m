Message-Id: <200010132147.XAA00867@piglet.grunz.lu>
Date: Fri, 13 Oct 2000 23:47:47 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dual head r128
To: bh40@calva.net
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19340907150812.9049@192.168.1.10>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ok, If I follow you correctly, that mean that if we have, for example,
> bus 1 set to 0x10000-0x1ffff, ioportremap() would return, for an address
> in this range, the address + bus_io_base - 0x10000. At least on Macs,
> AFAIK, we have only 64k or 128k of IOs available.

No, the regions are larger. Apple's doc talks about '23 bits of IO
space', which is 8M, at least for the first-generation bridges (bandit,
that is).

Anyway, the best way to find out the size of this region (unless you can
read it from the bridge) is to look at the OF device tree, and the
bridge's region properties.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
