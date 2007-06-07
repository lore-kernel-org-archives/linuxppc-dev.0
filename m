Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 9F6E0DDECF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 16:21:01 +1000 (EST)
Date: Thu, 7 Jun 2007 08:20:54 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: a question on "iowrite32()"
Message-ID: <20070607062054.GD23294@moe.telargo.com>
References: <BAY138-F6B2DA6BEF021C7026E522B2270@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY138-F6B2DA6BEF021C7026E522B2270@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 06/06/07 19:30 +0000, Ming Liu wrote:
> Dear all,
> I am writing a device driver for my customized PLB hardware module on my 
> PPC405 & Xilinx ML403 architecture. In the driver code, I use a 
> "iowrite32()" function to initiate a DMA transfer. However, I found that if 
> I program as "iowrite32(0x12345678, address);", actually I am writing 
> 0x87654321 to that address. However if I write a standalone program without 
> a Linux OS, the Xilinx function "XIo_Out32()" just write the correct value 
> 0x12345678 into address. Can anyone explain my why this happens? I know 
> that PPC405 is a big-endian system. But I don't think this is a endian 
> problem. After all endian is only an issue of the CPU architecture, not the 
> OS. Am I right?

out_be32?
I recall something about iowrite32 being PCI stuff and therefore little
endian, but don't count on this being right.


	Domen
