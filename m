Message-Id: <200005251849.UAA00650@piglet.grunz.lu>
Date: Thu, 25 May 2000 20:49:24 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: ide_dmaproc
To: Henning.Loeser@Physik.Uni-Marburg.DE
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.4.02.10005251944580.15015-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  25 May, this message from Henning Loeser echoed through cyberspace:
> encouraged by Simon success with his Promise IDE card I went for
> an other try with my AEC6260M ide card.

Welcome to the club ;-)

> I patched a standart 2.2.15 kernel source with Andre's ide-patches (they
> wouldn't install on Pauls rsynced stable tree)

Yeah, I haven't bothered to rsync the stable tree, as kernel.org has
always worked fine for me....

> I keep getting errormassages stateing:
>>ide_dmaproc: chipset supported ide_dma_lostirq func only: 11

Could you provide the complete detection messages from dmesg, and a full
line of error meessage? You might also want to contact Andre about
this...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
