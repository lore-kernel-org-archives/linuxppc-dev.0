Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sTvP2j4QzF1Rn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:59:13 +1000 (AEST)
In-Reply-To: <1527058932-7434-3-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [v4,02/29] powerpc: add TEXASR related macros
Message-Id: <40sTvN6rXWz9s1w@ozlabs.org>
Date: Fri, 25 May 2018 11:59:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 07:01:45 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patches add some macros for CR0/TEXASR bits so that PR KVM TM
> logic(tbegin./treclaim./tabort.) can make use of them later.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/ab3759b5734544dd1430527c3d8973

cheers
