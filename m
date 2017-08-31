Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjSsj4hvwzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:44:09 +1000 (AEST)
Date: Thu, 31 Aug 2017 13:42:10 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, schwab@linux-m68k.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix invalid use of register
 expression
Message-ID: <20170831034210.GD22549@fergus.ozlabs.ibm.com>
References: <1502771821-10316-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502771821-10316-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 15, 2017 at 02:37:01PM +1000, Michael Ellerman wrote:
> From: Andreas Schwab <schwab@linux-m68k.org>
> 
> binutils >= 2.26 now warns about misuse of register expressions in
> assembler operands that are actually literals. In this instance r0 is
> being used where a literal 0 should be used.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> [mpe: Split into separate KVM patch, tweak change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
