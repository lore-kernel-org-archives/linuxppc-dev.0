Date: Thu, 21 Mar 2002 14:15:36 -0800
To: Jim Potter <jrp@wvi.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	trini@kernel.crashing.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020321221536.GB6671@zumanetworks.com>
References: <0203201704.AA10152@ivan.Harhan.ORG> <20020321143633.V6003@altus.drgw.net> <3C9A31D2.1E46C989@mvista.com> <3C9A5270.CEDAF9F5@wvi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C9A5270.CEDAF9F5@wvi.com>
From: Nye Liu <nyet@zumanetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 21, 2002 at 01:36:48PM -0800, Jim Potter wrote:
> Now that things are settling down a bit -- who's got which tree running on which
> platform and in what condition?  Basically, what's the conditon of the 2_4_galileo and
> 2_4_devel tree's on EVB, MVP, (etc) -- SMP y/n, PCI cards (scsi, ide, etc) y/n,
> running solid y/n, and under which boot environment (dink, ppcboot, starmon, etc)?

I have _gal and _devel running on the EVB and _gal running our custom
board with ppcboot. Both are stable; the _gal has a bunch of other stuff
and random bug fixes in it. _devel does not work on our custom board due
to ethernet bugs, mpsc problems, and no 750cx support. _devel does also
not work 100% with ppcboot since it does not support bd_info afaik.

We are using the 750cx(e). We do not use DINK. We do have an Abatron.

Note that our evb is showing signs of breaking (the cpu module slot seems
to be a real weak point), so we may end up just like Mark any second now.

--
Nye Liu
nyet@zumanetworks.com

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
