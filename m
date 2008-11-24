Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB9B3DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 06:47:36 +1100 (EST)
Message-ID: <492B04BD.5060402@freescale.com>
Date: Mon, 24 Nov 2008 13:47:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
References: <OFDD6E2111.A0808007-ON8825750B.0067D813-8825750B.0067EC1C@selinc.com>
In-Reply-To: <OFDD6E2111.A0808007-ON8825750B.0067D813-8825750B.0067EC1C@selinc.com>
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
> The hardware doesn't care (I'm using an MPC8347E), as far as the DMA 
> engine is concerned these are just addresses.  All of this goes to cache 
> coherency.  The map/unmap functions are supposed to ensure that data is 
> copied and caches flushed at the right times to ensure cache coherency. So 
> 
> the question is this; is the dma_async_memcpy_buf_to_buf() function 
> intended to be bi-directional and is it safe to pass it a 'src' pointer 
> that's actually coming from the device, or does there need to be a second 
> function for doing a copy from the device to the CPU?

The "device" is the DMA engine, thus src is inherently going to the 
device and dest is inherently coming from the device.

-Scott
