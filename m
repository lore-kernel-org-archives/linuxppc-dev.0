Date: Thu, 11 Apr 02 09:24:24 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111624.AA28797@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> Don't get to conclusions so fast. We have already a whole bunch of new
> machines support pending in _devel that has to be merged, and that will
> happen after 2.4.19. Things aren't fast on a stable kernel, but that's
> the way it should be.

Then why won't you accept my PPCStar port into 2_4_devel?

> Not having it as a module may prevent pcmcia modems from working.

OK, now I see the fundamental conflict of interest. Your machines and mine
can't coexist in the same kernel I guess then because mine can't work with the
serial driver as a module (because it's the system console) and yours can't
work with it compiled in because of PCMCIA. Let's have separate
CONFIG_CHRP_PMAC_PREP and CONFIG_HEC_PPCSTAR then.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
