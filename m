Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9rS14crRzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 21:50:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org
Subject: Re: [PATCH RESEND 1/1] KVM: PPC: Book3S: Add MMIO emulation for VMX
 instructions
In-Reply-To: <20171226130011.26561-2-joserz@linux.vnet.ibm.com>
References: <20171226130011.26561-1-joserz@linux.vnet.ibm.com>
 <20171226130011.26561-2-joserz@linux.vnet.ibm.com>
Date: Tue, 02 Jan 2018 21:50:05 +1100
Message-ID: <87608ktu02.fsf@concordia.ellerman.id.au>
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

Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:

> This patch provides the MMIO load/store vector indexed
> X-Form emulation.
>
> Instructions implemented: lvx, stvx
>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h   |   2 +
>  arch/powerpc/include/asm/kvm_ppc.h    |   4 +
>  arch/powerpc/include/asm/ppc-opcode.h |   6 ++
>  arch/powerpc/kvm/emulate_loadstore.c  |  32 +++++++
>  arch/powerpc/kvm/powerpc.c            | 162 ++++++++++++++++++++++++++++++----
>  5 files changed, 189 insertions(+), 17 deletions(-)

KVM patches should be Cc'ed to kvm-ppc@vger.kernel.org, that way Paul
will see them in his patchwork at:

  http://patchwork.ozlabs.org/project/kvm-ppc/list/

cheers
