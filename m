Return-Path: <medp@primagraphics.co.uk>
Received: from mail.primagraphics.com (unknown [81.20.3.25])
	by ozlabs.org (Postfix) with SMTP id 0C25A2BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Dec 2004 20:55:33 +1100 (EST)
Message-ID: <41BD657F.7010000@primagraphics.co.uk>
Date: Mon, 13 Dec 2004 09:48:47 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: cwernham@airspan.com
References: <41B8255A.3040101@airspan.com>
In-Reply-To: <41B8255A.3040101@airspan.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PPC4XX DMA polarity bug in linuxppc-2.6.9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Colin Wernham wrote:

> I believe that there is a PPC4xx DMA driver bug in the following 
> kernel, file and function:
>   linuxppc-2.6.9,
>    /arch/ppc/syslib/ppc4xx_dma.c,
>    ppc4xx_init_dma_channel()
>
>
> Is there anyone else using the PPC4XX DMA?

FWIW
I have used the PPC4xx dma on 405GP systems and a 440GP system with 
2.4.21 and 2.4.25. I found the ppc4xx_dma.c functions didn't work in the 
way I needed. I just read the code very carefully and used a few of the 
functions combined with some direct manipulation of the DMA registers.

As I recall, I don't think the polarity is the only problem in that 
file. It certainly doesn't support the 440 DMA registers - the COUNT 
register is different.

The code in ppc4xx_dma.c is however, very useful as a guide in how to go 
about setting up a DMA transfer; just read it carefully with the 
processor manual to hand.

-- 
Mark Powell, Senior Software Engineer
Curtiss-Wright Controls Embedded Computing
Tel: +44 (0) 1763 852222
Email: medp@primagraphics.com
