Date: Wed, 18 Oct 2000 22:08:53 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
In-Reply-To: <Pine.LNX.4.10.10010181316430.841-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10010181831001.17346-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I've given up on this - the build tools included in the source package are
> > binary only (Intel or Sparc), no sources so far as I can see, and the
> > stuff in config_office has a number of hardcoded assumptions that make
> > life miserable (gcc version == 2.95.2, jdk 1.2.2 which requires glibc
> > 2.1.3, Linux only exists on Intel and Sparc, ...). Basically, it sucks.
>                               ^^^^^^^^^^^^^^^
> Look at the bright side: at least the code should be endianness and 64-bit
> clean :-)

Byte endianness clean, perhaps. 64 bit clean? You wish: sparc64 was not an
explicit option. What does uname -m on a sparc64 give?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
