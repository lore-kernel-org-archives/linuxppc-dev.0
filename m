Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id EEE5367B60
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 05:50:42 +1000 (EST)
Subject: Re: DMA buffer synchronisation with ioremap()
From: Lee Revell <rlrevell@joe-job.com>
To: Phil.Nitschke@avalon.com.au
In-Reply-To: <1154351427.3203.59.camel@toby.int.avalon.com.au>
References: <1154351427.3203.59.camel@toby.int.avalon.com.au>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 15:51:15 -0400
Message-Id: <1154461876.14540.70.camel@mindpipe>
Mime-Version: 1.0
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

On Mon, 2006-07-31 at 22:40 +0930, Phil Nitschke wrote:
> (I go no replies last week, so I'll try again, with less explanation...)
> 
> If I master a DMA from a PCI device into a main memory buffer allocated
> with dma_alloc_noncoherent(), I need to synchronise the destination
> buffer using dma_sync_single_range_for_xxx() before and after the DMA.
> 
> But if the buffer is a very large chunk of memory (reserved at boot
> time) which has been ioremap()-ed into the virtual address space, do I
> need to still synchronise that memory?

Maybe it's a better question for the linux-kernel list?

Lee
