Message-ID: <3DEF0B81.8060106@elsoft.ch>
Date: Thu, 05 Dec 2002 09:17:05 +0100
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ISA dma on 4xx
References: <15854.51654.206530.977151@argo.ozlabs.ibm.com>
In-Reply-To: <15854.51654.206530.977151@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello


Paul Mackerras wrote:

> Is anyone using a pc-style southbridge chip in a 4xx-based system?
>
> I am thinking that the split that we currently have in linuxppc-2.5,
> where asm/dma.h includes either ppc4xx_dma.h or ppc_isa_dma.h, is not
> the best way to do things, because we might want to use the ISA dma
> functions on a 4xx system.

Yes, we are using ISA DMA in combination with a PPC405GP. Currently
ISA DMA is used for things like floppy or IrDA (implemented in a SuperIO
chip).

>
> Does anyone use the 4xx dma controller with some device that is
> normally connected to an ISA bus?  That is, is there a need for the
> 4xx dma functions to provide the same interface as the ISA dma
> functions?
>
> Paul.
>
Am i right that you want to create a common interface capable of
handling 4xx DMA and ISA DMA at the same time?


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
