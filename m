Message-ID: <38CBE616.DD8B9D37@wanadoo.fr>
Date: Sun, 12 Mar 2000 19:46:46 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: mlan@cpu.lu
Subject: Re: defconfig for pmac in 2.3.51 and up
References: <200003121551.QAA00488@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> >> (digging a little further...) Oh I see, bitkeeper doesn't have the
> >> complete collection of arch/ppc/configs/*_defconfig files any more; no
> >> more chrp, pmac, or prep. I still have them from a previous version.
> >> Weird...
>
> Wouldn't this be a side-effect of trying to 'unify' all the PPC
> configs? There's only a generic PPC config option as well, an no more
> CONFIG_PMAC, CONFIG_PREP, CONFIG_CHRP etc.., thy are all replaced by
> the single CONFIG_ALL_PPC.

If this disappearance of the 3 defconfig files is by purpose, then the
arch/ppc/Makefile should be told about it, too. There you still find 9
different *_config targets, but 3 of them won't work because the
respective *_defconfig files have disappeared. The 6 other oddball
*_defconfig files are still there.

> I think it still makes sense, though, to keep the default configs for
> each hardware type. Makes kernel config a lot easier...

Developers only ever use make oldconfig, so the other make *config
options are notoriously untested.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
