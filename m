Date: Wed, 7 Aug 2002 10:12:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: acurtis@directvinternet.com,
	"David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>,
	linuxppc-dev@lists.linuxppc.org, lm@bitmover.com
Subject: Re: Problem with bk repository?
Message-ID: <20020807001252.GF5012@zax>
References: <3D4FEA26.1070403@elsoft.ch> <NCBBIINEHIPFGJPLBEIFEEGMDKAA.acurtis@directvinternet.com> <20020806161339.GB714@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020806161339.GB714@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 06, 2002 at 09:13:39AM -0700, Tom Rini wrote:
> On Tue, Aug 06, 2002 at 08:46:50AM -0700, acurtis@directvinternet.com wrote:
> >
> > >
> > > david@devil:/repository/linuxppc_2_4_devel>bk parent
> > > Parent repository is bk://ppc.bkbits.net/linuxppc_2_4_devel
> > > david@devil:/repository/linuxppc_2_4_devel>bk pull -ll
> > > ERROR-Can't get read lock on the repository.
> > > pull: remote locked, trying again...
> > > ERROR-Can't get read lock on the repository.
> > > pull: remote locked, trying again...
> > > ERROR-Can't get read lock on the repository.
> > > pull: remote locked, trying again...
> > > ERROR-Can't get read lock on the repository.
> > > pull: remote locked, trying again...
> >
> > I was it for the first time today too.
>
> Are either of you still getting this?  What seems to be happening is
> that when David Gibson pushes something to the tree, it never quite
> finishes and Bk ends up in a slightly wierd state.  David, are you
> behind some sort of wierd network setup or anything?

Ah, crap.  I did run into this the other day - I did a push which got
interrupted (connection closed by foreign host - probably due to
SOCKS).  After that my pulls (and attempts to push again) complained
that there was a lock.  But paulus had a look at the parent repository
where 'll' denied that there was any lock - at least it did the second
time it was invoked.  My pulls were still failing and I was going to
send out a mail, but the next day it seemed to be working again, so I
figured it was a once off breakage.

I guess I was wrong.

I'm not sure if my last push was interrupted, or whether there was
some residual breakage from the earlier push in the repository which
got triggered again by the later push.

Pulls are working again for me now, so I'm not sure what to do next to
investigate this.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
