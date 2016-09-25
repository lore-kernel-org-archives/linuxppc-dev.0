Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzz2QzMzDrPM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:15 +1000 (AEST)
In-Reply-To: <20160919105855.435AF1A2455@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc: fix usage of _PAGE_RO in hugepage
Message-Id: <3shWzz09hFz9s5g@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-19-09 at 10:58:54 UTC, Christophe Leroy wrote:
> On some CPUs like the 8xx, _PAGE_RW hence _PAGE_WRITE is defined
> as 0 and _PAGE_RO has to be set when a page is not writable
> 
> _PAGE_RO is defined by default in pte-common.h, however BOOK3S/64
> doesn't include that file so _PAGE_RO has to be defined explicitly
> in book3s/64/pgtable.h
> 
> fixes: a7b9f671f2d14 ("powerpc32: adds handling of _PAGE_RO")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b8cb66a6a7cc182b47da6a0a1

cheers
