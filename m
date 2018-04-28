Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Y7SY0xRZzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 21:12:45 +1000 (AEST)
In-Reply-To: <20180426123319.10843-1-laurentiu.tudor@nxp.com>
To: laurentiu.tudor@nxp.com, kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: powerpc/kvm/booke: fix altivec related build break
Message-Id: <40Y7SY04mQz9s15@ozlabs.org>
Date: Sat, 28 Apr 2018 21:12:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-26 at 12:33:19 UTC, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add missing "altivec unavailable" interrupt injection helper
> thus fixing the linker error below:
> 
> arch/powerpc/kvm/emulate_loadstore.o: In function `kvmppc_check_altivec_disabled':
> arch/powerpc/kvm/emulate_loadstore.c: undefined reference to `.kvmppc_core_queue_vec_unavail'
> 
> Fixes: 09f984961c137c4b ("KVM: PPC: Book3S: Add MMIO emulation for VMX instructions")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b2d7ecbe355698010a6b7a15eb179e

cheers
