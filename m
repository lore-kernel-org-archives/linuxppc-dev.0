Date: Mon, 16 Jul 2001 11:12:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel ftp ?
Message-ID: <20010716111241.M29668@work.bitmover.com>
References: <20010716182910.21970@smtp.adsl.oleane.com> <Pine.LNX.4.10.10107162000360.20223-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10107162000360.20223-100000@zirkon.biophys.uni-duesseldorf.de>; from schmitz@zirkon.biophys.uni-duesseldorf.de on Mon, Jul 16, 2001 at 08:01:35PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 16, 2001 at 08:01:35PM +0200, Michael Schmitz wrote:
> > >Which are hosted by montavista:
> > >rsync -avz --delete source.mvista.com::linuxppc_2_4 <directory>
> > >
> > >for the 'stable' 2.4 tree.
> >
> > Those are mirrors, the main repository is hosted by bitmover
> > (ppc.bitkeeper.com). But those mirrors should work fine as well..
>
> Yep, but does the bitmover sire offer rsync access? That's what most of us
> still use ...

No, we do not and will not offer rsync or FTP access.  Those are very
bandwidth intensive services, BK uses a tiny fraction of what they use,
and you can accomplish the same thing with a

	rm -rf /tmp/exported_tree
	bk pull
	bk export -tplain /tmp/exported_tree

That's way, way, way less bytes moved to get you a perfect mirror.
I really don't care if you use BK or not to do development, that is up
to you.  But you should use it to conserve bandwidth and you must use
it if you want the data from us.

I can easily understand you not wanting to learn a new tool, or having
some other reason, valid or otherwise, not to use BK.  That's fine.
But you need to understand that anyone providing a hosting service is
spending money to do so.  We've spent about $25K to date.  Right now,
we're behind a pair of T1 speed DSL lines that cost us about $800/month.
If we fill up those lines the DSL people will shut us down and we'll
have to move to real T1 lines.  That would at least triple our costs.
I think it's a lot more than that, last I checked a fractional T1,
around 400Kbits/sec, was $1000/month.

Our way around this problem is to get you to do one "bk clone" and only
"bk pulls" after that.  That will transfer _only_ the data which has to
be transferred, nothing else.  Even that is a substantial amount when
you multiply it all out by the number of people.  We'll deal with that,
we won't deal with full copies.

I know Mvista offers rsync/ftp access and they're welcome to do so.  They
make (some) money off of Linux/PPC so they can justify it.  I suspect,
however, when they find out that FTP/rsync is filling up a T1 line and they
have to buy more bandwidth, their management may raise a stink.  Money is
money, it's one thing to spend it when there is no other choice, it's quite
another for people to be wasteful.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
