Message-ID: <3CE37B49.6000508@elsoft.ch>
Date: Thu, 16 May 2002 11:26:33 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
References: <3CE2481B.5070108@elsoft.ch> <20020515155200.GN721@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini schrieb:
> On Wed, May 15, 2002 at 01:35:55PM +0200, "David M?ller (ELSOFT AG)" wrote:
>
>
>>The attached patch fixes the following issues:
>
>
> Looks good, except:
> Don't #ifdef externs, if they aren't used it's OK.
> Since this code only has to work in recent'ish kernels (in reality only
> 'current' kernels) don't bother with the
> #ifdef MODULE_LICENSE
> ...
> #endif
>
> Just use it.
>

I have copied the MODULE_LICENSE stuff from another driver.
Does anybody knows if this feature is tagged to be a remove candiate in
future kernels and/or in the modutils?


Another question:

I've noticed that (at least) the following files have their executable
bit set, although they are simple C source files.
./include/asm-ppc/ppc405_dma.h
./arch/ppc/kernel/ppc405_dma.c
./arch/ppc/kernel/ppc405_pci.c
./arch/ppc/kernel/ppc4xx_setup.c
./arch/ppc/platforms/walnut.c
./arch/ppc/platforms/cpc700_pic.c

On the other hand, the PPCBoot kernel packer script in
./arch/ppc/boot/utils/mkimage.wrapper have the exec bit cleared.

Is it a bit task to fix this?


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
