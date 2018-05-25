Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sTvP0vypzF1P7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:59:13 +1000 (AEST)
In-Reply-To: <1527058932-7434-2-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [v4,01/29] powerpc: export symbol msr_check_and_set().
Message-Id: <40sTvN3WTzz9s0q@ozlabs.org>
Date: Fri, 25 May 2018 11:59:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 07:01:44 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> PR KVM will need to reuse msr_check_and_set().
> This patch exports this API for reuse.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/d1c7211281c5e1799f00b222815753

cheers
