Date: Sun, 21 Jan 2001 15:42:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [patch] missing exported symbols
Message-ID: <20010121154201.D6223@opus.bloom.county>
References: <20010121144057.A27643@wibble.net> <20010121142823.B6223@opus.bloom.county> <20010122091135.A19788@chiru.svana.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010122091135.A19788@chiru.svana.org>; from sjh@svana.org on Mon, Jan 22, 2001 at 09:11:35AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 22, 2001 at 09:11:35AM +1100, Steven Hanley wrote:
>
> On Sun, Jan 21, 2001 at 02:28:23PM -0700, Tom Rini wrote:
> > On Sun, Jan 21, 2001 at 02:40:57PM +1100, Steven Hanley wrote:
> >
> > > The first one I am pretty sure belongs in this file as i have noticed a few
> > > other archs have to export it here.
> >
> > Err, what needs this symbol tho?  And are you sure this is actually needed?
> > I'm about to re-do my modtest config vs 2.4.1pre9, but as of ~2.4.0 release
> > or an early 2.4.1 the bk tree was fine wrt modules now..  And, as of 2.4.1pre9
> > only sh exports flush_dcache_page, and sparc64 exports __flush_dcache_page,
> > so are you sure this is needed?
>
> smbfs and nfs modules, I need nfsa, I notice it works fine in 2.4.0 on i386,
> jiust it has not worked for more than a month in the 2.4) type kernels on
> ppc.

Er, I would switch trees if I were you then.  NFS in bk 2_4/2_5 has been
working great here (nfs & nfsd) and neither need flush_dcache_page added there
(Because it's been added to the normal netsyms, now that I think of it.)

> > > The gmac one i am unsure if this is the best place to put the export, but it
> > > works so I put it here.
> >
> > This has been fixed in the 2_4 bk for atleast a week, and 2_5 for much longer.
>
> Was that the correct place to export it?

For 2_4, yes.  2_5 I moved lots of garbage (makefile junk > preprocessor
magic) and has feature_xxx exported in feature.c

> I tend to run paulus kernels, probably mostly because I have rsync or cvs
> available, have not played with bk yet (though I am su re it is easy) and
> also that I tend to be able to go speak with paulus in person or such if I
> want to ask him stuff or some such.

The 2_4 bk tree has an rsync avail.  Paulus even commits to the bk tree from
time to time. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
