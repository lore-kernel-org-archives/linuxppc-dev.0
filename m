Date: Thu, 7 Sep 2000 23:43:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: newer xfree86 4.0.1 patches
In-Reply-To: <Pine.LNX.4.10.10009071853430.461-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10009072337350.9578-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > If you want to keep the current state of affairs I can see in the
> > > linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On the
> > > other hand, if you plan to integrate your input drivers into 2.4, it makes
> > > perfect sense.
> >
> > I think it would be nice, but to be honest I don't fully understand what would
> > be involved.
>
> I hope this is _not_ about translating whatever-keyboard-type-keycodes to
> PC-style keycodes? We (ehrm, I) already opened that can of worms somewhere in
> 1995, and closed it ASAP.

I don't recall the details (and have no list archives that far back) but
it wasn't a bit pretty. But at that time there was no generic HID support
to use, and that might make a difference now (if it works for ADB
keyboards it might work for Amiga as well).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
