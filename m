Date: Mon, 2 Jul 2001 20:35:26 -0700
From: Matt Porter <mporter@mvista.com>
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Current state of the 2_4_devel tree
Message-ID: <20010702203526.B19868@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.3.95.1010702051131.4368C-100000@november.bhjjh.erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.95.1010702051131.4368C-100000@november.bhjjh.erols.com>; from ghurwitz@dyndns.com on Mon, Jul 02, 2001 at 05:34:44AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 02, 2001 at 05:34:44AM -0400, Justin (Gus) Hurwitz wrote:

> Cautiously pessemistic, I then did a make config; make clean; make dep;
> make zImage.initrd. The compile wen smoothly until near the end- there
> were problems in arch/ppc/mm, compiling init.c. The errors are below.
>
> I didn't touch either init.c, or mmu_decl.h, so I would assume that there
> should be no errors, unless the current stae of the source tree is
> uncompilable :)

<snip>

I saw some similar dependency problems after arch/ppc/mm/init.c split.
'make mrproper' should clear things up for you.  If you not familiar
with it, be sure to preserve your .config because it will be removed.

I'm able to build all my board ports after cleaning up the
stale dependencies this way.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
