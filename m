Date: Wed, 15 Mar 2000 15:46:50 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound split
In-Reply-To: <20000315113909.D352@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1000315154608.19480C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Mar 2000, Tom Rini wrote:

>
> On Tue, Mar 14, 2000 at 09:14:23AM +0100, Geert Uytterhoeven wrote:
>
> > On Tue, 7 Mar 2000, Geert Uytterhoeven wrote:
> > > On Tue, 7 Mar 2000, Geert Uytterhoeven wrote:
> > > > This is my first test release for splitting the DMA sound driver in different
> > > > parts:
> > >
> > > And here's a first patch:
> >
> > No comments whether it works on PowerMac and Atari?
>
> Ah, right.  I tried it out on a 9600 and it worked, and seemingly better than
> before (no loud hiss when insmod'ed).  Only sugjestion I would make is to
> follow the trend of drivers/XXX/bigdriver/xxx.c instead of dmasound_*.c

I noticed that the loud hiss was gone in kernels/modules built a couple of
weeks ago, too, for whatever that's worth.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
