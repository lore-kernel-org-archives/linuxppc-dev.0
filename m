Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDF10DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 07:11:20 +1100 (EST)
In-Reply-To: <492B04BD.5060402@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
MIME-Version: 1.0
Message-ID: <OFDA95F0F0.C47AEAA0-ON8825750B.006E5AC8-8825750B.006EC783@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 24 Nov 2008 12:10:10 -0800
Content-Type: text/plain; charset="US-ASCII"
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

Hi Scott,

Thanks for the reply.

> > 
> > the question is this; is the dma_async_memcpy_buf_to_buf() function 
> > intended to be bi-directional and is it safe to pass it a 'src' 
pointer 
> > that's actually coming from the device, or does there need to be a 
second 
> > function for doing a copy from the device to the CPU?
> 
> The "device" is the DMA engine, thus src is inherently going to the 
> device and dest is inherently coming from the device.
>

Yes, I understand the directions and what they apply to, that's obvious 
from the macros themselves.  What I don't understand is if it's safe, from 
a kernel/cache standpoint, to pass to the function a src pointer coming 
_from_ the device and a dest pointer that's going _to_ the device?  In 
other words, can I use this function to _write_ to a DMA slave?  If not, 
there's a functionality missing from the async DMA engine.

Thanks.

Bruce
