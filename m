Date: Thu, 16 May 2002 06:56:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
Message-ID: <20020516135643.GF20456@opus.bloom.county>
References: <3CE2481B.5070108@elsoft.ch> <20020515155200.GN721@opus.bloom.county> <3CE37B49.6000508@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CE37B49.6000508@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 16, 2002 at 11:26:33AM +0200, "David M?ller (ELSOFT AG)" wrote:
> Tom Rini schrieb:
> >On Wed, May 15, 2002 at 01:35:55PM +0200, "David M?ller (ELSOFT AG)" wrote:
> >
> >
> >>The attached patch fixes the following issues:
> >
> >
> >Looks good, except:
> >Don't #ifdef externs, if they aren't used it's OK.
> >Since this code only has to work in recent'ish kernels (in reality only
> >'current' kernels) don't bother with the
> >#ifdef MODULE_LICENSE
> >...
> >#endif
> >
> >Just use it.
> >
>
> I have copied the MODULE_LICENSE stuff from another driver.
> Does anybody knows if this feature is tagged to be a remove candidate in
> future kernels and/or in the modutils?

Unfortunately, no.  I think other drivers do it for backwards
compatibility, which we don't have to worry about.

> Another question:
>
> I've noticed that (at least) the following files have their executable
> bit set, although they are simple C source files.
> ./include/asm-ppc/ppc405_dma.h
> ./arch/ppc/kernel/ppc405_dma.c
> ./arch/ppc/kernel/ppc405_pci.c
> ./arch/ppc/kernel/ppc4xx_setup.c
> ./arch/ppc/platforms/walnut.c
> ./arch/ppc/platforms/cpc700_pic.c
>
> On the other hand, the PPCBoot kernel packer script in
> ./arch/ppc/boot/utils/mkimage.wrapper have the exec bit cleared.
>
> Is it a bit task to fix this?

I assume you ment big.  And no, I've just fixed these.  Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
