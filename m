Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3Y69HFzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:09 +1100 (AEDT)
In-Reply-To: <20161202023837.GK2697@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [2/2] powerpc: Fix missing CRCs,
 add yet more asm-prototypes.h declarations
Message-Id: <3vnW3Y4whkz9s80@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-02 at 02:38:38 UTC, Ben Hutchings wrote:
> Add declarations for:
> - __mfdcr, __mtdcr (if CONFIG_PPC_DCR_NATIVE=y; through <asm/dcr.h>)
> - switch_mmu_context (if CONFIG_PPC_BOOK3S_64=n; through <asm/mmu_context.h>)
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43a8888f0a70db62488fc3ad1505f6

cheers
