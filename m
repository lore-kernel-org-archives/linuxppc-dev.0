Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V3XB55KBzF36h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:05:30 +1000 (AEST)
In-Reply-To: <20180704061349.20742-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel,v3,1/6] powerpc/powernv: Remove useless wrapper
Message-Id: <41V3XB30Ndz9s0w@ozlabs.org>
Date: Tue, 17 Jul 2018 12:05:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-04 at 06:13:44 UTC, Alexey Kardashevskiy wrote:
> This gets rid of a useless wrapper around
> pnv_pci_ioda2_table_free_pages().
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Series applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/da2bb0da730c5c427f66ce501aa436

cheers
