Date: Thu, 16 Mar 2000 22:15:58 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: michdaen@iiic.ethz.ch
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <20000316112537.6597.qmail@web124.yahoomail.com>
Message-ID: <Pine.LNX.4.10.10003162214240.10090-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Weird. Are you sure the `81fff000' is not caused by some fixup routine
> > > that changed the unassigned `fffff000' into `81fff000'?
> >
> > What part of the kernel would do that kind of fixup?
>
> *_fixup in arch/ppc/kernel/*_pci.c

The only function in pmac_pci.c does no such thing. Next question: how
would I modify the bus mappings from aty_init?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
