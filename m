Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdm6xBjzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:52 +1000 (AEST)
In-Reply-To: <20170327082737.14448-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v2] powerpc/powernv: Check kzalloc() return value in
 pnv_pci_table_alloc
Message-Id: <3wGTdm5b82z9sDF@ozlabs.org>
Date: Mon,  1 May 2017 12:58:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-27 at 08:27:37 UTC, Alexey Kardashevskiy wrote:
> pnv_pci_table_alloc() ignores possible failure from kzalloc_node(),
> this adds a check. There are 2 callers of pnv_pci_table_alloc(),
> one already checks for tbl!=NULL, this adds WARN_ON() to the other path
> which only happens during boot time in IODA1 and not expected to fail.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/82eae1afbbdcaf2d716f88025736dc

cheers
