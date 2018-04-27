Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XNv32SRKzF262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 16:14:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: laurentiu.tudor@nxp.com, kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] powerpc/kvm/booke: fix altivec related build break
In-Reply-To: <20180426123319.10843-1-laurentiu.tudor@nxp.com>
References: <20180426123319.10843-1-laurentiu.tudor@nxp.com>
Date: Fri, 27 Apr 2018 16:14:37 +1000
Message-ID: <874ljx5g6q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

laurentiu.tudor@nxp.com writes:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add missing "altivec unavailable" interrupt injection helper
> thus fixing the linker error below:
>
> arch/powerpc/kvm/emulate_loadstore.o: In function `kvmppc_check_altivec_disabled':
> arch/powerpc/kvm/emulate_loadstore.c: undefined reference to `.kvmppc_core_queue_vec_unavail'
>
> Fixes: 09f984961c137c4b ("KVM: PPC: Book3S: Add MMIO emulation for VMX instructions")

What config are you using to hit this? I'd like to add it to my
auto-builder to catch it in future.

cheers
