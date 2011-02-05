Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3982CB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 13:05:03 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re: minimum guaranteed alignment of dma_alloc_coherent?
Date: Sat, 5 Feb 2011 02:04:40 +0000
Message-ID: <4D4CB038.9020602@freescale.com>
References: <AANLkTi=1VkJM6hJH44jeUmYwoEtJj22d6WyKVDitg=KY@mail.gmail.com>
	<2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
In-Reply-To: <2A5A3DDA-94B3-48E3-9E49-6A5260BE1484@digitaldans.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek wrote:
>
>
>> On a side note, do I really need to pass GFP_DMA ....
>
> The GFP_DMA is architecture dependent.  Are you writing
> a driver to be used across multiple architectures?

It's conceivable that the driver could work on PowerPC and ARM.

> If it's
> necessary, I'd document why you are using it (an ISA device
> on x86 for example) and then let other architectures
> determine if it's necessary for them.

I guess I'm not clear.  I was wondering why an API called "dma_alloc_cohere=
nt" (that has the word "dma" in it) needs to be told to allocate DMA-safe m=
emory.  When would it make sense to call dma_alloc_cohernet without GFP_DMA=
?  If you don't want DMA-able memory, then you shouldn't be calling dma_all=
oc_anything.

--=20
Timur Tabi
Linux kernel developer=
