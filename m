Date: Wed, 18 Feb 2004 16:45:54 +0100
From: Kiko Piris <linuxppc@pirispons.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Message-ID: <20040218154554.GA15438@fpirisp.portsdebalears.com>
References: <1077074495.1082.94.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077074495.1082.94.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 18/02/2004 at 14:21, Benjamin Herrenschmidt wrote:

> Hi need people who own those machiens, especially the recent iBook2 models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.

Hi, I've compiled and I'm running it on my iBook2 (G3).

In fact I've applied your patch _plus_ laptop mode and orinoco monitor
mode. I guess they have nothing to see one each other but...

I've put it to sleep a couple of times (once before starting X and some
more while running X) and noticed nothing unusual.

Let me know if I can provide additional info or test anything else.

Thanks


Info about hardware & config follows:
-------------------------------------

$ uname -a
Linux sacarino 2.6.3-rc3-ben1-benhtest #1 Wed Feb 18 16:19:59 CET 2004 ppc GNU/Linux

$ cat /proc/cpuinfo
processor       : 0
cpu             : 750FX
temperature     : 43 C (uncalibrated)
clock           : 900MHz
revision        : 2.3 (pvr 7000 0203)
bogomips        : 1785.85
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld

Kernel config can be found at http://www.pirispons.net/bulma/llista/iBook/

--
Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
