Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft03n8XzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:08 +1000 (AEST)
In-Reply-To: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
To: Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: misc: ocxl: Change return type for fault handler
Message-Id: <41Qft01FR3zB4MS@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-11 at 20:29:04 UTC, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There is an existing bug when vm_insert_pfn() can return
> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
> default. The new inline vmf_insert_pfn() has removed
> this inefficiency by returning correct vm_fault_ type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a545cf032d11437ed86e62f00d4991

cheers
