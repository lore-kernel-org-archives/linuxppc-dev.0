Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS038NXzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:40 +1000 (AEST)
In-Reply-To: <1470213656-1042-5-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel,
 04/15] powerpc/powernv/ioda: Fix TCE invalidate to work in real mode
 again
Message-Id: <3s7sS00PtGz9t22@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-08 at 08:40:45 UTC, Alexey Kardashevskiy wrote:
> "powerpc/powernv/pci: Rework accessing the TCE invalidate register"
> broke TCE invalidation on IODA2/PHB3 for real mode.
> 
> This makes invalidate work again.
> 
> Fixes: fd141d1a99a3
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4d9021957b5218310e28767f25

cheers
