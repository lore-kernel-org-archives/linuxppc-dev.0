Date: Mon, 29 Jan 2001 16:24:25 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Brad Midgley <brad@turbolinux.com>, linuxppc-dev@lists.linuxppc.org,
        djosg@mgu.bath.ac.uk
Subject: Re: pmud monitoring temperature (Re: powerbook doubles)
Message-ID: <20010129162425.A21300@altus.drgw.net>
References: <200101290141.RAA21010@mail.turbolinux.com> <Pine.LNX.4.30.0101291534510.2636-200000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0101291534510.2636-200000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Mon, Jan 29, 2001 at 03:49:02PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 29, 2001 at 03:49:02PM +0100, Michael Schmitz wrote:
> > i reworked this patch to work with the current bk tree (argh. i just complained to iain that diffs
> > against a moving target were gross)
> >
> > http://redcloud.uccs.edu/~bcmidgle/linux/
> >
> > btw, it looks like troy wants the _{gs}et_THRM{123} macros changed to use some different macros,
> > but i'm not familiar with that stuff so i just reenabled the old macros.
>
> I don't think what changes you propose there but from the comment on your
> patch page ('cpu speed not included in calculations') it seems you picked
> up the old version of the patch. I attach the version including
> conversion time calculation from processor speed (for 2.4.0pre). The CPU
> speed is  preset to 500 MHz in case it can't be determined from OF, this
> gives too long conversion times for slower processors - does this hurt?
> What is the maximum CPU speed for machines without clock_frequency
> present in the device tree?

Guys, you should *really* take a look at the CONFIG_TAU stuff in linuxppc_2_5.
It's interrupt driven, so the delay doesn't really matter, and you can't cause
a DOS by infinitely re-reading /proc/cpuinfo.

And does anyone think this is tested enough to move to linuxppc_2_4?

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
