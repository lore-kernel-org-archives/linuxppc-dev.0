Date: Tue, 20 Aug 2002 18:33:19 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 rsync tree broken
Message-ID: <20020820163319.GB912@naboo.de.gnumonks.org>
References: <20020819200140.A9590@sunbeam.de.gnumonks.org> <20020820143837.GA891@opus.bloom.county>
Mime-Version: 1.0
In-Reply-To: <20020820143837.GA891@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 20, 2002 at 07:38:37AM -0700, Tom Rini wrote:
> On Mon, Aug 19, 2002 at 08:01:40PM +0200, Harald Welte wrote:
>
> > The current (at least yesterday and today) linuxppc-2.5 tree at
> > source.mvista.com is broken.
> >
> > It is totally missing the directories sound/core and drivers/usb/core.
>
> What flags are you passing to rsync?  Both of those directories exist in
> the tree rsync serves from.

Thanks, as pointed out by Michael it was due to the 'C' flag which is
default in all of my rsync scripts.  Should have read the docs first ;)

Sorry for my bogus bugreport.

> Tom Rini (TR1265)

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M-=
=20
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
