Message-ID: <3C21A301.2080204@elsoft.ch>
Date: Thu, 20 Dec 2001 09:36:17 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA
References: <3C206A41.1080501@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

Seems like you are facing the same problem as i do. But IIRC i think you
have to adjust the code in include/asm/dma.h (and possibly other places)
as well (at least in 2.4.14, not sure about the later kernels).

BTW:

What south bridge do you use? Some of the newer ones offer 32bit
addressing capability for DMA.

Adrian Cox wrote:

> The current 2.4-devel tree never assigns any memory to the ISA DMA zone,
> irrespective of the setting of ISA_DMA_THRESHOLD. As I'm currently
> trying to get a floppy working on a platform with 24-bit ISA DMA in its
> Southbridge, this looks like a problem.
>
> How do people feel about the attached patch? This should only change
> behavior for platforms which set ISA_DMA_THRESHOLD to a value other than
> 0 or (-1)L.
>


[stuff deleted]


Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
