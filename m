Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs08d0Db3zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 14:37:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v11 09/10] KVM: PPC: iommu: Unify TCE checking
In-Reply-To: <20170322042156.11756-10-aik@ozlabs.ru>
References: <20170322042156.11756-1-aik@ozlabs.ru>
 <20170322042156.11756-10-aik@ozlabs.ru>
Date: Mon, 27 Mar 2017 14:36:33 +1100
Message-ID: <87h92ffl1a.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> This reworks helpers for checking TCE update parameters in way they
> can be used in KVM.
>
> This should cause no behavioral change.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes:
> v6:
> * s/tce/gpa/ as TCE without permission bits is a GPA and this is what is
> passed everywhere
> ---
>  arch/powerpc/include/asm/iommu.h    | 20 +++++++++++++++-----
>  arch/powerpc/include/asm/kvm_ppc.h  |  6 ++++--
>  arch/powerpc/kernel/iommu.c         | 37 +++++++++++++------------------------
>  arch/powerpc/kvm/book3s_64_vio_hv.c | 31 +++++++------------------------

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
