Date: Tue, 9 Apr 02 12:23:57 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204091923.AA23957@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Well, take a look at what the file used to look like in _devel.  It was
> around 30-40 lines of that.  Which is not nice to look at.

So what's more important, a pretty look or better functionality for the user?

> Well, it's a much better system if you want to group unlike hardware
> together in one kernel. :)

Which is what I want to do, and which is the RTTD for distributions like
Debian.

> Well, if ISA slots exist on the board, and should be working, they
> should just work.  And when BenH merges in prep/chrp, it'll be needed.
> But the question is do you really want to offer this up on machines
> where it's not tested?

I want to have configurable CONFIG_PCI and CONFIG_ISA support for
CONFIG_GENERIC_PPC32. Generic means that things like this must be configurable.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
