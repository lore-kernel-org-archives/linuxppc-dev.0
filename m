Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 42FC9679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 05:06:35 +1000 (EST)
Date: Sat, 7 May 2005 11:05:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050507140527.GC16996@logos.cnet>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
	<6f231f4afce0886929ca99426a86b47a@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f231f4afce0886929ca99426a86b47a@embeddededge.com>
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


> NO.  Just leave that code alone.  I don't understand why you think
> doing this will have any effect on the system operation.  If you are
> able to run a system without creating these tables, then the pinned
> TLBs must be working.  If pinned TLBs weren't working, the kernel
> would crash.

I just booted a kernel with 4kb PTE mappings at KERNELBASE and
the pinned TLB was not trashed.

So, I was talking nonsense. :)

The only problem are DMA users who dont use dma_alloc_coherent API. 
