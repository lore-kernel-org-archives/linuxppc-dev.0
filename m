Message-ID: <3CE4A3C8.8060507@elsoft.ch>
Date: Fri, 17 May 2002 08:31:36 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
References: <3CE2481B.5070108@elsoft.ch> <20020515155200.GN721@opus.bloom.county> <3CE37B49.6000508@elsoft.ch> <20020516135643.GF20456@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini schrieb:
> On Thu, May 16, 2002 at 11:26:33AM +0200, "David M?ller (ELSOFT AG)" wrote:
>

[old stuff deleted]

>>Another question:
>>
>>I've noticed that (at least) the following files have their executable
>>bit set, although they are simple C source files.
>>./include/asm-ppc/ppc405_dma.h
>>./arch/ppc/kernel/ppc405_dma.c
>>./arch/ppc/kernel/ppc405_pci.c
>>./arch/ppc/kernel/ppc4xx_setup.c
>>./arch/ppc/platforms/walnut.c
>>./arch/ppc/platforms/cpc700_pic.c
>>
>>On the other hand, the PPCBoot kernel packer script in
>>./arch/ppc/boot/utils/mkimage.wrapper have the exec bit cleared.
>>
>>Is it a bit task to fix this?
>
>
> I assume you ment big.  And no, I've just fixed these.  Thanks.
>

Yes, of course. Here's the list of exec bit set files for 2.5.15:
./arch/ppc/kernel/ppc405_dma.c
./arch/ppc/kernel/ppc405_pci.c
./arch/ppc/kernel/ppc4xx_serial.c
./arch/ppc/kernel/ppc4xx_setup.c
./arch/ppc/platforms/walnut.c
./include/asm-ppc/ppc405_dma.h


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
