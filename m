Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqn1gvMzF1mw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:57 +1000 (AEST)
In-Reply-To: <20180524110206.EFE226C991@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix invalid register expression in head_8xx.S
Message-Id: <40skqm5m3yz9s1w@ozlabs.org>
Date: Fri, 25 May 2018 21:41:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-24 at 11:02:06 UTC, Christophe Leroy wrote:
> New binutils generate the following warning
> 
>   AS      arch/powerpc/kernel/head_8xx.o
> arch/powerpc/kernel/head_8xx.S: Assembler messages:
> arch/powerpc/kernel/head_8xx.S:916: Warning: invalid register expression
> 
> This patch fixes it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4ccb1dae6bdef228d729c076c3816

cheers
