Date: Wed, 15 Mar 2000 11:39:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound split
Message-ID: <20000315113909.D352@opus.bloom.county>
References: <Pine.LNX.4.05.10003072247180.484-100000@callisto.of.borg> <Pine.LNX.4.05.10003140902060.19873-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10003140902060.19873-100000@callisto.of.borg>; from geert@linux-m68k.org on Tue, Mar 14, 2000 at 09:14:23AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 14, 2000 at 09:14:23AM +0100, Geert Uytterhoeven wrote:

> On Tue, 7 Mar 2000, Geert Uytterhoeven wrote:
> > On Tue, 7 Mar 2000, Geert Uytterhoeven wrote:
> > > This is my first test release for splitting the DMA sound driver in different
> > > parts:
> >
> > And here's a first patch:
>
> No comments whether it works on PowerMac and Atari?

Ah, right.  I tried it out on a 9600 and it worked, and seemingly better than
before (no loud hiss when insmod'ed).  Only sugjestion I would make is to
follow the trend of drivers/XXX/bigdriver/xxx.c instead of dmasound_*.c

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
