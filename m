Date: Thu, 11 Apr 02 13:51:38 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204112051.AA29511@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> When you say push "it" are you referring to all of your changes or just the
> CONFIG_GENERIC_PPC32 stuff?

I was referring to CONFIG_GENERIC_PPC32. My GT-64260 and EV-64260A work would
be nice too though. :)

> From what I can tell, it
> looks like you moved much of the init functionality that was in gt64260_common and
> put it into ev64260_pci.c, et. al., and got rid of the "library" routines in
> gt64260_common.

I have replaced gt64260_common.c with gt64260_data.c and gt64260_utils.c so
that one can choose to use the utility functions for non-OF non-StarMON boards
or not use them for good OF/StarMON, but still always have the crucial global
variables.

> IMO, this is a large step backwards.

I disagree.

> The purpose of all the arch/ppc/*_common
> files is to provide a "library" for each bridge.  They aren't perfect and one of
> my TODO item over the next few months is to improve all of them but they provide
> common code that initializes and supports that particular bridge.  Having these
> files have played a large part in making ports to systems with MPC106/107/824x
> chips, for example, much simpler and much faster.  That is the purpose of
> gt64260_common.c but you just deleted it and put that code in a non-reusable,
> board-specific file.

Then fine, keep that library and use it for your ports to your heart's delight.
Just please let HEC ports not use it.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
