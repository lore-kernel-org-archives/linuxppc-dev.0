Date: Wed, 18 Oct 2000 17:20:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
Message-ID: <20001018172044.E15104@opus.bloom.county>
References: <Pine.LNX.4.10.10010172057330.27337-100000@opal.biophys.uni-duesseldorf.de> <Pine.LNX.4.10.10010181316430.841-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10010181316430.841-100000@cassiopeia.home>; from geert@linux-m68k.org on Wed, Oct 18, 2000 at 01:17:17PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 18, 2000 at 01:17:17PM +0200, Geert Uytterhoeven wrote:
>
> On Tue, 17 Oct 2000, Michael Schmitz wrote:
> > > is anyone trying to get the now opensource staroffice to compile on
> > > linux/ppc?
> >
> > I've given up on this - the build tools included in the source package are
> > binary only (Intel or Sparc), no sources so far as I can see, and the
> > stuff in config_office has a number of hardcoded assumptions that make
> > life miserable (gcc version == 2.95.2, jdk 1.2.2 which requires glibc
> > 2.1.3, Linux only exists on Intel and Sparc, ...). Basically, it sucks.
>                               ^^^^^^^^^^^^^^^
> Look at the bright side: at least the code should be endianness and 64-bit
> clean :-)

Well, maybe anyways.  Are you sure it's Linux/x86 and Linux/sparc not
Linux/x86 and Solaris/sparc and Solaris/x86? :)  Anyways,
http://porting.openoffice.org/ implies anwyays the src for the tools should be
around.  Finally, gcc 2.95.2 (or 2.95.3) and glibc 2.1.3 are good for you.
JDK 1.2.2 should be fine (Kevin?)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
