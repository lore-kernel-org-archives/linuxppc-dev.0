Message-Id: <sbd7c48d.025@tms-pty.com>
Date: Thu, 25 Oct 2001 07:51:30 +1100
From: "Jeremy Rosen" <Rosen.Jeremy@tms-pty.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx IDE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I am also trying to have pcmcia to work on my FADS board...
it is already configured in the denx kernel for the following boards
ivms8,lwmon.spd8xx,tqm8xx

to have it, it seems (havn't investigated deeply yet ) that their are
just a couple of #define to add...
most of them are common to all board, but one of them is giving me
serious problems : IDE0_INTERRUPT
I tried to find out in my boards documentation what interrupt was to be
assigned to pcmcia, but I didn't find...
did I miss something ???

>>> Laurent Pinchart <laurent.pinchart@capflow.com> 10/24/01 10:47PM
>>>

Hi

While trying to find an easy way to add non-volatile storage on a
custion MPC860 board, I noticed that there was some support for IDE on
the PCMCIA interface in the Linux kernel.

Does anyone know where I can find more information about that ? There
seems to be a board (IVMS8) with such an IDE interface, but I haven't
been able to find anything about it on the web.

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
