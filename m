Date: Thu, 13 Jun 2002 08:43:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC405GPr support patch (and a small CPCI405 update)
Message-ID: <20020613154355.GR13541@opus.bloom.county>
References: <EFEAIMDCOOOHIEPHDNFJCEAKEBAA.stefan.roese@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFEAIMDCOOOHIEPHDNFJCEAKEBAA.stefan.roese@esd-electronics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 05:00:50PM +0200, Stefan Roese wrote:

> By the way:
> Upon looking into cputable.c I noticed that all NP4xx ppc's have the wrong
> cache line size configured (total cache size in kB instead of cache line
> size). May this cause some problems?

Well, if glibc ever makes use of those entries (see
http://bugs.debian.org/100657) it might.  But for now, iirc it's
probably harmless.  Patches accepted of course.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
