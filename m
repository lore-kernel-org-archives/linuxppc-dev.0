Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9183167B69
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 01:30:41 +1000 (EST)
In-Reply-To: <42C40BD0.8040408@anagramm.de>
References: <42C40BD0.8040408@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 30 Jun 2005 10:30:41 -0500
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jun 30, 2005, at 10:12 AM, Clemens Koller wrote:

> Hello!
>
> I am planning to use DMA/burst access for copying large chunks of data
> (100MBytes) from the Local Bus (UPM accessed SRAM) to System Memory  
> (DDR)
> as fast as possible (200MBytes/s). (As you can guess, that's a  
> framegrabber).
>
> As far as I have seen, the DMA engines of the MPC85xx (fsl-dma) are  
> not
> supported in the classical way (dma_request(), free_dma()) in the  
> kernel 2.6.x.
> The memory allocators in arch/ppc/dma-mapping.c seem to be usable,
> but there is no valuable dma support yet (true?).
>
> I can program the DMA Controllers in my MPC8540 on my own to  
> achieve what I want
> but it would be great to get/produce/stick with as much cross- 
> platform reusable
> code as possible.
>
> Is there any ongoing work to put DMA support for the mpc85xx and  
> similar
> devices into the kernel? Is there any ongoing work in this area
> or is somebody working with the fsl-dma and can publish some code and
> share some ideas?

I'm not aware of anyone work on such a thing.  I'd be more than happy  
to accept patches for it.  I know several of us have written some  
APIs on top of the DMA for 85xx.  Those however are non-standard APIs.

What APIs exist for general purpose DMA engines?  Last time I looked  
at this problem nothing really existed.

- kumar
