Date: Mon, 26 Jul 2004 09:30:54 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Song Sam <samlinuxppc@yahoo.com.cn>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches
Message-ID: <20040726163054.GA8872@gate.ebshome.net>
References: <20040726134847.84704.qmail@web15214.mail.bjs.yahoo.com> <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 26, 2004 at 10:27:52AM -0400, David Woodhouse wrote:
> Because nobody's really that interested in it. For what it's worth, I've
> abandoned all pretence of continuing to support 2.4 in the MTD/JFFS2 CVS
> tree.

This is quite sad, but not all maintainers do the same. IIRC networking fixes
are still backported to 2.4.

Hopefully, I can maintain this stuff myself and backport fixes (what I already
did for some MTD stuff, btw).

> > > I would not consider deploying anything on 2.6
> > > today. IMHO it's not mature
> > > enough to be used in production environment.
> >
> > I do agree with the view.I guess it is most embedded
> > developers's opinion.
>
> Out of interest, how many platforms are you using 2.6 on and how does
> your experience with these platforms support your stated view?

How the number of platforms is relevant for this discussion? It should work on
one I use, it's quite academic for me if it works fine on another. Could you
point me to _any_ distribution which is shipping_2.6 PPC 4xx based kernel with
working preemption? Last time I tried this on Ebony it wasn't quite stable.

A little history, IMO we get something we can call "production quality" 2.4
PPC 4xx only in the end of 2003. It took me almost 1.5 years to get 2.4 stable
on platforms I use (fixing some nasty bugs on the way, even MTD ones :P). After
that I'm quite reluctant to switch to 2.6 right now, just because some
maintainers lost interest in 2.4.

--
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
