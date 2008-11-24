Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4337EDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 08:28:26 +1100 (EST)
Message-ID: <492B1C74.9070700@freescale.com>
Date: Mon, 24 Nov 2008 15:28:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
References: <OF5164841E.9891D22C-ON8825750B.0074160D-8825750B.007587B6@selinc.com>
In-Reply-To: <OF5164841E.9891D22C-ON8825750B.0074160D-8825750B.007587B6@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
> Maybe (with you clarification) this is starting to make sense.  It doesn't 
> matter if the "src" is host memory or PCI space.  What the "src" and it's 
> DMA_TO_DEVICE mapping is saying to the kernel is "this data needs to be 
> moved into the DMA engine", while the "dest" and it's DMA_FROM_DEIVCE 
> mapping is telling the kernel "this data needs to be moved from the DMA 
> engine".

Right.

-Scott
