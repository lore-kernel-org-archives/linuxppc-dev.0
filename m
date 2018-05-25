Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sTvP3ddfzF1Rm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:59:13 +1000 (AEST)
In-Reply-To: <1527058932-7434-4-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [v4, 03/29] powerpc: export tm_enable()/tm_disable/tm_abort() APIs
Message-Id: <40sTvP2CYrz9s28@ozlabs.org>
Date: Fri, 25 May 2018 11:59:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 07:01:46 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch exports tm_enable()/tm_disable/tm_abort() APIs, which
> will be used for PR KVM transaction memory logic.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/eacbb218fbbab5923775059f7232a9

cheers
