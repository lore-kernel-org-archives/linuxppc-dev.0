Date: Wed, 20 Mar 2002 09:19:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020320161931.GF3762@opus.bloom.county>
References: <20020320131924.29210@mailhost.mipsys.com> <0203201530.AA09802@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203201530.AA09802@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 20, 2002 at 07:30:38AM -0800, Michael Sokolov wrote:
>
> benh@kernel.crashing.org wrote:
>
> > This is the wrong approach. What we should do instead is have the gt eth
> > driver
> > do some kind of find_bi_rec(BI_GT64260_ETH_CFG). setup.c doesn't have to be
> > changed each time a new birec is added, and your approach seem wrong if
> > that driver ever becomes a module.
>
> Then push my patch defining the new bi_recs, and once it's in I'll make another
> one to implement what you just suggested. But if patches aren't being accepted
> there is no incentive for me to make or improve them.

Sure there is, for it to be accepted.  And would you please make it
versus the _galileo tree so that other users of GT-64260 can easily test
your changes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
