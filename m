Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EB911A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 19:44:32 +1000 (AEST)
In-Reply-To: <1436180050-27397-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: powerpc/tm: Drop tm_orig_msr from thread_struct
Message-Id: <20150722094432.2407F1402C4@ozlabs.org>
Date: Wed, 22 Jul 2015 19:44:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-07 at 10:54:10 UTC, Anshuman Khandual wrote:
> Currently tm_orig_msr is getting used during process context switch only.
> Then there is ckpt_regs which saves the checkpointed userspace context
> The MSR slot contained in ckpt_regs structure can be used during process
> context switch instead of tm_orig_msr, thus allowing us to drop it from
> thread_struct structure. This patch does that change.
> 
> Acked-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/829023df86d4ec39b110

cheers
