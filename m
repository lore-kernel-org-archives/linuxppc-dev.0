Date: Fri, 28 Jul 2000 12:39:44 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: mlan@cpu.lu, schmitz@opal.biophys.uni-duesseldorf.de, geert@linux-m68k.org,
        linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: MacSerial and Serial driver cohabitation
In-Reply-To: <20000728083743.21545@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10007281237510.26855-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Whoever fixes this problem should be decorated, and a statue put up in
> >his memory. ;-)
> >
> >But if anyone is brave enough to attempt it, don't forget that there are
> >_two_ places where serial ports are probed for: serial console init very
> >early in the booting, and driver init much later in the boot process.
> >Those two should be guaranteed to be in sync re minor assignment/device
> >naming. Right now, that's not the case.
>
> My current rsync tree contains a fix done by Andreas Tobler that helps
> cohabitation of macserial and legacy serial. I know Paul and Theodore
> have been working on a more definitive fix, I don't know it's status however,

We will have to find a way to adopt the more definitive fix for m68k
anyway, that's something constantly slipping down on my todo list but it's
been on there for over a year now. I'll ask Paul and Ted about details.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
