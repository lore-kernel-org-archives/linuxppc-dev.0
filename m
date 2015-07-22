Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E42131A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 19:44:30 +1000 (AEST)
In-Reply-To: <1437361123-18615-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [V2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
Message-Id: <20150722094430.C7B571402D2@ozlabs.org>
Date: Wed, 22 Jul 2015 19:44:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-20-07 at 02:58:43 UTC, Anshuman Khandual wrote:
> This patch adds one helper function 'sigcontext_vmx_regs' which computes
> quad word aligned pointer for 'vmx_reserve' array element in sigcontext
> structure making the code more readable.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2476c09f391eddb546a7

cheers
