Message-ID: <3813AFA8.FF28094F@drgw.net>
Date: Sun, 24 Oct 1999 20:17:28 -0500
From: Troy Benjegerdes <hozer@drgw.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: need Open PIC infos
References: <19991016191421.027499@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> Hi !
> 
> I'm working on support for new UMA machines (beginning with iBook). I
> have already figured out a lot of things and am now coding a very
> preliminary support (I'm not sure yet the PMU99 will work out of the box
> or not, but it looks similar to the old PMU from an interface point of view).
> 
> However, the new Apple ASICs contains an Open PIC interrupt controller
> (advertised as beeing a "chrp,open-pic" controller). After looking at the
> various docs I have and a quick search on Altavista, I couldn't find any
> relevant documentation on the chip.
> There's already some OpenPIC support in the kernel, but I'll have to
> change it a little bit since, for example, Apple hardware is not a good
> place to search for a 8259 master ;)
> I'd like some docs in order to have better understanding of the chip.
> 
> Anyone knows if such a doc exist ? Apparently, if the register map is not
> completely bogus, the current code returns an OpenPIC versio 1.2, and the
> timer freq is 0x80000000 (ouch !).

You might try the programmers manual for the Motorola MTX series
motherboard, which has an OpenPIC (and an 8259, unfortunately). I believe
arch/ppc/kernel/openpic.c is a mostly complete implementation. Last I
checked (about kernel 2.2.5 or so) the only major thing missing was some
interprocessor interrupt support.

If you haven't already, you might check out the PReP and CHRP specific
kernel code, since both CHRP and some PReP machines use it.

Hope this helps. 

Troy-- Anxiously awaiting a Sawtooth G4 to start hacking on

-- 
--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
