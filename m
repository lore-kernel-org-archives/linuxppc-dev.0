Message-Id: <6.0.1.1.2.20031202171803.02dcd420@mail.lauterbach.com>
Date: Tue, 02 Dec 2003 17:21:41 +0100
To: Harald Welte <laforge@gnumonks.org>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
References: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
 <1069386878.876.49.camel@gaston>
 <20031121153314.GC23224@sunbeam.de.gnumonks.org>
 <20031130155530.GK26749@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 16:55 30.11.2003, Harald Welte wrote:

>On Fri, Nov 21, 2003 at 04:32:52PM +0100, Harald Welte wrote:
> >
> > On Fri, Nov 21, 2003 at 02:54:38PM +1100, Benjamin Herrenschmidt wrote:
> >
> > > Interesting. Same machine here and I use 2.6 everyday :)
> >
> > The problem seems to be gcc-related. Debian testing seems to have
> > installed gcc-3.3.2 (yes, maybe not the best compiler for a kernel
> > anyway) per default.
> >
> > compiling the same kernel with gcc-2.95 results in a working ipv6
> > module.
>
>I did some more testing:
>
>Compiles with gcc-3.3.2 and gcc-3.2.3 result in a broken kernel,
>gcc-3.0.4 and gcc-2.95.4 work fine.

Works fine for me with bk linuxppc-2.5 (test9/10/11), gcc-3.3.2 and
binutils-2.14.90.0.6. gcc is built from the gcc-3_3-rhl-branch, binutils as
in fedora development.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
