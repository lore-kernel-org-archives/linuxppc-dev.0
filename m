Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sTvN1LGnzF1P7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:59:12 +1000 (AEST)
In-Reply-To: <20180328195811.27758-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,04/19] powerpc/kvm: Prefer fault_in_pages_readable function
Message-Id: <40sTvM71Vbz9s1b@ozlabs.org>
Date: Fri, 25 May 2018 11:59:11 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-28 at 19:58:11 UTC, Mathieu Malaterre wrote:
> Directly use fault_in_pages_readable instead of manual __get_user code. Fix
> warning treated as error with W=1:
> 
>   arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/9f9eae5ce717f497812dfc1bda5219

cheers
