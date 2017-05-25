Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVLJ248MzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:22:32 +1000 (AEST)
In-Reply-To: <1495608599-16819-1-git-send-email-jk@ozlabs.org>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sombat Tragolgosol <sombat3960@gmail.com>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: powerpc/spufs: Fix hash faults for kernel regions
Message-Id: <3wYVLJ04Xkz9s9Y@ozlabs.org>
Date: Thu, 25 May 2017 23:22:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-24 at 06:49:59 UTC, Jeremy Kerr wrote:
> Change ac29c64089b7 swapped _PAGE_USER for _PAGE_PRIVILEGED, and
> introduced check_pte_access() which denied kernel access to
> non-_PAGE_PRIVILEGED pages.
> 
> However, it didn't add _PAGE_PRIVILEGED to the hash fault handler for
> spufs' kernel accesses, so the DMAs required to establish SPE memory
> no longer work.
> 
> This change adds _PAGE_PRIVILEGED to the hash fault handler for
> kernel accesses.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Reported-by: Sombat Tragolgosol <sombat3960@gmail.com>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d75e4919cc0b6fbcbc8d6654ef66d8

cheers
