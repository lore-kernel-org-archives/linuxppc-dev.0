Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id C3AD967A00
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 16:25:59 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j496UZA1023117
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 09:30:36 +0300 (EEST)
Message-ID: <427EFEAF.6030903@intracom.gr>
Date: Mon, 09 May 2005 09:09:51 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
	<6f231f4afce0886929ca99426a86b47a@embeddededge.com>
	<20050507140527.GC16996@logos.cnet>
In-Reply-To: <20050507140527.GC16996@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
>>NO.  Just leave that code alone.  I don't understand why you think
>>doing this will have any effect on the system operation.  If you are
>>able to run a system without creating these tables, then the pinned
>>TLBs must be working.  If pinned TLBs weren't working, the kernel
>>would crash.
> 
> 
> I just booted a kernel with 4kb PTE mappings at KERNELBASE and
> the pinned TLB was not trashed.
> 
> So, I was talking nonsense. :)
> 
> The only problem are DMA users who dont use dma_alloc_coherent API. 
> 
> 
> 

Perhaps I'm jumping in too late, but in my 8xx trees all my drivers
use the correct API. So this will not be a problem after we fix the
drivers :)

Regards

Pantelis
