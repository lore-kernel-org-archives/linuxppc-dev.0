Date: Wed, 18 Apr 2001 09:39:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>,
	Cort Dougan <cort@fsmlabs.com>, linuxppc-commit@fsmlabs.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: CPU features again
Message-ID: <20010418093941.C13403@opus.bloom.county>
References: <20010418160328.15973@mailhost.mipsys.com> <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, Apr 18, 2001 at 06:36:05PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 18, 2001 at 06:36:05PM +0200, Geert Uytterhoeven wrote:
> On Wed, 18 Apr 2001, Benjamin Herrenschmidt wrote:
> > Those feature bits have to be common accross the entire PPC range (and
> > possibly common with ppc64 too since ppc64 is supposed to run ppc32
> > binaries, except that ppc64 has 32 more bits to stuff it's own features
> > for 64 bits binaries).
>
> BTW, we don't take the sparc64/mips64 approach and create arch/ppc64/?
> Sparc64/mips64 run 32-bit binaries as well.

That's a 2.5 planned thing, I believe.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
