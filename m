Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7JH5RrtzF0VR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:39 +1100 (AEDT)
In-Reply-To: <20180112022849.30899-4-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [4/5] powerpc: Remove useless EXC_COMMON_HV
Message-Id: <3zM7JC4KF6z9t3p@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-12 at 02:28:48 UTC, Benjamin Herrenschmidt wrote:
> The only difference between EXC_COMMON_HV and EXC_COMMON is that the
> former adds "2" to the trap number which is supposed to represent the
> fact that this is an "HV" interrupt which uses HSRR0/1.
> 
> However KVM is the only one who cares and it has its own separate macros.
> 
> In fact, we only have one user of EXC_COMMON_HV and it's for an
> unknown interrupt case. All the other ones already using EXC_COMMON.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/872e2ae4bdd4c244f7617ffc08c394

cheers
