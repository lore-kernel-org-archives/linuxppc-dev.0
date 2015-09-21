Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EDD31A023F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 07:58:59 +1000 (AEST)
Message-ID: <1442872723.19102.188.camel@freescale.com>
Subject: Re: [PATCH 03/31] powerpc/mm: make a separate copy for book3s
From: Scott Wood <scottwood@freescale.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Sep 2015 16:58:43 -0500
In-Reply-To: <1442817658-2588-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
> In this patch we do:
> cp pgtable-ppc32.h book3s/32/pgtable.h
> cp pgtable-ppc64.h book3s/64/pgtable.h
> 
> This enable us to do further changes to hash specific config.
> We will change the page table format for 64bit hash in later patches.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 340 +++++++++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 618 
> +++++++++++++++++++++++++++
>  arch/powerpc/include/asm/book3s/pgtable.h    |  10 +
>  arch/powerpc/include/asm/mmu-hash64.h        |   2 +-
>  arch/powerpc/include/asm/pgtable-ppc32.h     |   2 -
>  arch/powerpc/include/asm/pgtable-ppc64.h     |   4 -
>  arch/powerpc/include/asm/pgtable.h           |   4 +
>  7 files changed, 973 insertions(+), 7 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/book3s/32/pgtable.h
>  create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
>  create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h

git format-patch -C?

Do the book3s/hash-specific parts of the copied file get removed from the non-
hash files at some point?

-Scott
