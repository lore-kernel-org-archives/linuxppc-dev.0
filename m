Date: Fri, 10 Aug 2001 08:16:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>, linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: PPC bk repos reorg
Message-ID: <20010810081659.A13789@work.bitmover.com>
References: <15218.2656.8980.846399@cargo.ozlabs.ibm.com> <20010808211410.J7728@work.bitmover.com> <15218.4778.270562.782105@cargo.ozlabs.ibm.com> <20010808213806.C13789@work.bitmover.com> <15218.7077.297813.862317@cargo.ozlabs.ibm.com> <20010809192852.L13789@work.bitmover.com> <20010810080751.B31136@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010810080751.B31136@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Fri, Aug 10, 2001 at 08:07:51AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 10, 2001 at 08:07:51AM -0700, Tom Rini wrote:
> On Thu, Aug 09, 2001 at 07:28:52PM -0700, Larry McVoy wrote:
>
> > c) URL changes
> >    Old anonymous:
> > 	bk://ppc.bitkeeper.com:5000..5004 these are going away
> >    New anonymous:
> > 	bk://ppc.bkserver.net/linux_2_2
> > 	bk://ppc.bkserver.net/linux_2_4
> > 	etc.
> >    Old ssh:
> > 	bk://ppc.linux_2_2@bitkeeper.com
> >    New ssh:
> > 	bk://ppc@ppc.bkserver.net/linux_2_2
> > 	bk://ppc@ppc.bkserver.net/linux_2_4
>
> And, er by request on IRC, 'linux_2_2' is still Linus' 2.2 tree, and
> 'linux_2_4' is still Linus' 2.4 tree.  Our trees are 'linuxppc_2_4',
> 'linuxppc_2_4_devel' and 'linuxppc_2_2'.

Yes, I should have said that.  All 5 are there, as you can see if you take
a peek at http://ppc.bkserver.net/

By the way, I snarfed a pile of domains for this: bkserver.{net,com},
bkmaster.{net,com}, bkprojects.{net,com}, bkbits.{net,com}.

I'd like to keep the .com for commercial hosting in case anyone wants
to give us huge piles of money (yeah, right, but you never know).
But I could use

	bk://ppc@ppc.bkbits.net/linux_2_2 instead of
	bk://ppc@ppc.bkserver.net/linux_2_2

It's a whole 2 letters shorter.  If I can ever get bk.net/bk.com that's
the obvious thing but the chances of that are right up there with me
winning the lottery.  If anyone stumbles across a really short, approrpiate
domain, let me know.  The nicest thing sourceforge ever did for me is
to get sf.net :-)

Anyway, all of the above addresses currently point at the same place.
If you all say "bkbits" then I'll reserve bkbits.net for the hosting
service.  I'm a big fan of less is more and that's the shortest I could
find.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
