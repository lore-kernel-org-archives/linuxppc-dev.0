From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 18 Nov 2003 08:04:06 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5xxx code issues
Message-ID: <20031118150406.GB8092@zenos.farnsworth.org>
References: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 17, 2003 at 08:29:44PM +0000, Tom Rini wrote:
> Must clean: These files need some sort of rewrite to look less like a
> drop of commerical code into the kernel and more like working the
> commercial code into the kernel:
> arch/ppc/5xxx_io/bestcomm/capi/Makefile
> arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
> arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
> arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)

The code beneath the arch/ppc/5xxx_io/bestcomm directory is supplied
by Motorola.  To ease the adoption of later revisions of this code,
we made minimal modifications.  Stupidly, the bestcomm code references
stdio.h, stdlib.h, string.h, but doesn't use their contents, so we
added empty files with these names.

The Makefiles are also supplied by Motorola and are not used by Linux
at all.  We can safely omit them to reduce confusion.

> defconfigs: Since I don't know the board families well (and google was
> no help here), should both IceCube and Glacier default to MPC5200 ?

IMHO, yes.

-Dale Farnsworth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
