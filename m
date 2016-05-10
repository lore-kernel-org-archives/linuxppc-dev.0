Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYf6RB4zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:38 +1000 (AEST)
In-Reply-To: <1456446386-28619-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [2/2] powerpc/mm: Improve readability of update_mmu_cache()
Message-Id: <3r4CYf5GQ9z9t4T@ozlabs.org>
Date: Wed, 11 May 2016 07:48:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-26-02 at 00:26:26 UTC, Gavin Shan wrote:
> The function is used to update the MMU with software PTE. It can
> be called by data access exception handler (0x300) or instruction
> access exception handler (0x400). If the function is called by
> 0x400 handler , the local variable @access is set to _PAGE_EXEC
> to indicate the software PTE should have that flag set. When the
> function is called by 0x300 handler, @access is set to zero.
> 
> This improves the readability of the function by replacing if
> statements with switch. No logical changes introduced.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f3ad731cc08cc4fd3855f25c36

cheers
