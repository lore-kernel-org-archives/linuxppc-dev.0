Message-Id: <200010050557.HAA00748@piglet.grunz.lu>
Date: Thu, 5 Oct 2000 07:57:01 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4 madness!
To: nicoya@apia.dhs.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a04b60151e18975@[24.70.162.14]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tony,

On   4 Oct, this message from Tony Mantler echoed through cyberspace:
> Ok, so in an effort to exploit cheap-ass IDE HDs, I'm playing around with a
> plain vanilla Promise ATA100 card in a Pmac 7600 (which currently runs
> 2.2.15 just fine).

Been there, done that, for a Promise Ultra66 ;-)

> I first tried compiling a 2.2.17 kernel with the latest ide patch, which
> resulted in a machine check on startup. bummer.

That could have been PCI problems....

Anyway, I'd suggest starting with:

1. Andre Hedrick's ATA patches (but I suppose you knew that), available
   somewhere on kernel.org, users/hedrick. AFAIK, the 2.2 patches
   _don't_ contain support for the U/100, though...

2. Get my PCI patches, available here:

   http://www.cpu.lu/~mlan/linux/dev/pci.html

...and cross fingers ;-)

Good luck

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
