Date: Wed, 19 Nov 2003 08:58:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5xxx code issues
Message-ID: <20031119155834.GB935@ip68-0-152-218.tc.ph.cox.net>
References: <20031117202944.GH30251@ip68-0-152-218.tc.ph.cox.net> <20031118150406.GB8092@zenos.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031118150406.GB8092@zenos.farnsworth.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 18, 2003 at 08:04:06AM -0700, Dale Farnsworth wrote:
>
> On Mon, Nov 17, 2003 at 08:29:44PM +0000, Tom Rini wrote:
> > Must clean: These files need some sort of rewrite to look less like a
> > drop of commerical code into the kernel and more like working the
> > commercial code into the kernel:
> > arch/ppc/5xxx_io/bestcomm/capi/Makefile
> > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos1/Makefile
> > arch/ppc/5xxx_io/bestcomm/code_dma/image_rtos2/Makefile
> > arch/ppc/5xxx_io/bestcomm/include/dummy files (should these be needed?)
>
> The code beneath the arch/ppc/5xxx_io/bestcomm directory is supplied
> by Motorola.  To ease the adoption of later revisions of this code,
> we made minimal modifications.  Stupidly, the bestcomm code references
> stdio.h, stdlib.h, string.h, but doesn't use their contents, so we
> added empty files with these names.

.. but those files _should_ be OK anyhow, if I recall all of the include
magic correctly.

> The Makefiles are also supplied by Motorola and are not used by Linux
> at all.  We can safely omit them to reduce confusion.

Can you give me a list of all of the files we don't actually need?
Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
