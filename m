Date: Wed, 20 Mar 02 07:30:38 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203201530.AA09802@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> This is the wrong approach. What we should do instead is have the gt eth
> driver
> do some kind of find_bi_rec(BI_GT64260_ETH_CFG). setup.c doesn't have to be
> changed each time a new birec is added, and your approach seem wrong if
> that driver ever becomes a module.

Then push my patch defining the new bi_recs, and once it's in I'll make another
one to implement what you just suggested. But if patches aren't being accepted
there is no incentive for me to make or improve them.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
