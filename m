Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrl00HtzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:47 +1000 (AEST)
In-Reply-To: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
To: Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org, jk@ozlabs.org,
 arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
Message-Id: <40mFrk2vxjz9s3c@ozlabs.org>
Date: Wed, 16 May 2018 23:38:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-20 at 17:32:39 UTC, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
> 
> We are fixing a minor bug, that the error from vm_insert_
> pfn() was being ignored and the effect of this is likely
> to be only felt in OOM situations.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e807f02c5c364c5a7315b50efdbc10

cheers
