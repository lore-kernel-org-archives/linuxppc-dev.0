Date: Sun, 30 Nov 2003 21:25:30 +0530
From: Harald Welte <laforge@gnumonks.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
Message-ID: <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org> <1069386878.876.49.camel@gaston> <20031121153314.GC23224@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
In-Reply-To: <20031121153314.GC23224@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 21, 2003 at 04:32:52PM +0100, Harald Welte wrote:
>
> On Fri, Nov 21, 2003 at 02:54:38PM +1100, Benjamin Herrenschmidt wrote:
>
> > Interesting. Same machine here and I use 2.6 everyday :)
>
> The problem seems to be gcc-related. Debian testing seems to have
> installed gcc-3.3.2 (yes, maybe not the best compiler for a kernel
> anyway) per default.
>
> compiling the same kernel with gcc-2.95 results in a working ipv6
> module.

I did some more testing:

Compiles with gcc-3.3.2 and gcc-3.2.3 result in a broken kernel,
gcc-3.0.4 and gcc-2.95.4 work fine.

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
