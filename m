Message-ID: <37FB4DA7.9120D5A@jlc.net>
Date: Wed, 06 Oct 1999 09:24:56 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Josh Huber <huberj@WPI.EDU>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: pcmcia-cs issues with flash?
References: <14330.56381.536665.10630@cpu.wpi.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:

> Has anyone had any luck with flash cards (compact flash in particular) with pcmcia adaptors on ppc? I've got a Wallstreet PBG3/233.

This has been broken for a long time.  Once in a while I spend a few moments
trying to fix it, but always get lost inside the IDE driver :-).


> And then, when I try and insert a compact flash card, this:
> Oct  5 21:01:15 majere kernel: ide_cs: ide_register() at 0x  0 & 0x  e, irq 23 failed

It is getting better :-).  It just crashes the kernel on my Wallstreet......


    -- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
