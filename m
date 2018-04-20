Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40STf12G5szF1sR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 07:34:49 +1000 (AEST)
Date: Fri, 20 Apr 2018 14:34:35 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: jk@ozlabs.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: platform: cell: spufs: Change return type to
 vm_fault_t
Message-ID: <20180420213435.GL10788@bombadil.infradead.org>
References: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420173239.GA24560@jordon-HP-15-Notebook-PC>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2018 at 11:02:39PM +0530, Souptick Joarder wrote:
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

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
