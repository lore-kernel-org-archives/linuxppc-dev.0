Date: Wed, 3 Dec 2003 11:35:45 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	benh@kernel.crashing.org, akuster@mvista.com,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: PPC4xx enet driver problem (version 2.0)
Message-ID: <20031203193545.GB28733@gate.ebshome.net>
References: <004901c3b990$b84d2ac0$0212000a@PCSTEFAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004901c3b990$b84d2ac0$0212000a@PCSTEFAN>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 03, 2003 at 12:29:31PM +0100, Stefan Roese wrote:
> We are trying to switch to the 2.4.23 linuxppc_2_4_devel kernel (from
> 2.4.21) and experience a problem with the "new" ethernet driver for the
> ibm ppc4xx (version 2.0 from Benjamin Herrenschmidt). On our boards with
> only one active enet interface we have no problems. But our PPC405EP
> boards with 2 active enet devices, the traffic stops completely upon
> initializing the 2nd devices (emac_reset_configure).
>
> Has anybody experienced similar problems? Has anybody seen this driver
> working properly with more than one ppc4xx enet devices (especially
> ppc405ep)?
>
> With the previous driver (from linuxppc_2_4_devel 2.4.21 maintained by
> mvista) we had no problems with 2 enet interfaces on the ppc405ep so
> far!
>
> By the way: What is the future of the ppc4xx enet driver. I found that
> the 2.5 kernel  has a newer mvista driver included (modifications for
> 440gx, etc.). Is the driver from 2.4.23 a dead end?

2.5 tree has an _old_ driver + some modifications + some 440GX code.

linuxppc-2.4 has a new driver re-written by Ben + some 440GX code.
Eventually 2.4 version will be merged into 2.5. So it is _not_ a dead
end, although it has some problems as you noticed.

Currently, Matt Porter is hacking on 440GX support and probably he (?)
will be the one who will merge 2.4 into 2.5.

I also have something done (mostly some stuff Ben havn't finished
during re-write, and some NAPI bits) sitting in my tree (I'm pretty
busy now to finish and push it to Matt :( ).

I'll try to look at your problem during this weekend, I don't have
405ep boards with two EMACs (yet), so I'll try to reproduce the
problem on 440GP/GX eval boards.

If you have some fixes feel free to post them here :).

Thanks,

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
