Date: Wed, 18 Oct 2000 18:06:57 -0700 (PDT)
From: William Blew <wblew@home.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
In-Reply-To: <Pine.LNX.4.10.10010181316430.841-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10010181805340.31353-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Oct 2000, Geert Uytterhoeven wrote:

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

I strongly suggest that anyone even thinking about this take a look at the
site. It has detailed build instructions that include how to build the
build tools.

--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
