Date: Sun, 24 Jun 01 21:32:06 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0106250432.AA04374@ivan.Harhan.ORG>
To: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch for SBS K2: don't initialise the L2 cache
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter <mporter@mvista.com> wrote:

> The only firmware available to date for an SBS K2 is PMON.  PMON does not
> configure the L2 cache.
>
> [...]
>
> When a firmware release is made available that properly sets up the L2CR
> then I'll be happy to remove the L2CR setup code, not before.

Here is the situation. I personally dislike PMON (quite strongly), and from my
personal conversations with Matt I've gathered that he shares my belief. (Matt,
please correct me if I'm wrong.) Furthermore, I'm ready to venture a guess that
any of the Linux/PPC maintainers who are Free Hackers (as opposed to
representing companies with a stake in the matter), given a demo and
description of PMON versus other possible firmware would very likely also find
PMON inferior. However, so far it seems like (for reasons that are outside my
realm of responsibility) SBS wants to stick with PMON for what it ships to
customers.

Here is what I propose to the Free Linux/PPC maintainers. Remember that the
very purpose of the Free public tree is to serve the interests of the Free
People not dominated by the interests of any particular company. Just like Red
Hat or anybody else working on GCC cannot make changes to the public GCC tree
only because their customers want the change and just like MontaVista or
anybody else working on Linux cannot make changes to the public Linux tree only
because their customers want the change, I similarly suggest that SBS's non-
technically-justifiable need to ship PMON to customers instead of StarMON be
kept out of the public Linux tree. I suggest that Free public Linux/PPC support
booting on SBS boards only under StarMON and not under PMON, even if SBS has to
ship PMON and an altered version of Linux that boots under it to its customers.
This way customers who insist on getting PMON can get it directly from SBS
without imposing it on the rest of the free world, and Free Hackers who want to
go by technical considerations only and not management decisions can use Free
StarMON and Free Linux from the net. If a board came with PMON, replacing it
with StarMON takes one erase/program cycle of the flash, of which the flash
manufacturer guarantees at least a million.

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or +1-888-SBS-COMM x2347
					Fax:   +1-760-438-6904
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
