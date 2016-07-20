Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvQrl3xkNzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 15:46:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, david@gibson.dropbear.id.au,
 aik@ozlabs.ru, agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
In-Reply-To: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
Date: Wed, 20 Jul 2016 15:46:30 +1000
Message-ID: <87vb00hnex.fsf@@concordia.ellerman.id.au>
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

Sam Bobroff <sam.bobroff@au1.ibm.com> writes:

> Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
> determine if a PowerPC KVM guest should use HTM (Hardware Transactional

Minor nit, "should" should be "can" IMHO.

> Memory).
>
> This will be used by QEMU to populate the pa-features bits in the
> guest's device tree.
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>
> v2:
>
> * Use CPU_FTR_TM_COMP instead of CPU_FTR_TM.

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Or do you want me to merge this before Paul gets back?

> * I didn't unbreak the line, as with the extra characters checkpatch will
>   complain if I do. I did move the break to a more usual place.

I would just ignore checkpatch. But I don't mind that much.

cheers
