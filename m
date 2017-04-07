Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzqSj4wXtzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 16:30:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, gleb@kernel.org,
 agraf@suse.de, KVM-PPC <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 pbonzini@redhat.com
Cc: KVM <kvm@vger.kernel.org>, david@gibson.dropbear.id.au
Subject: Re: [PATCH v8 2/3] powerpc/book3s: EXPORT_SYMBOL
 machine_check_print_event_info
In-Reply-To: <149150087155.9475.11789033992324470445.stgit@jupiter.in.ibm.com>
References: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
 <149150087155.9475.11789033992324470445.stgit@jupiter.in.ibm.com>
Date: Fri, 07 Apr 2017 16:30:10 +1000
Message-ID: <87wpawhgr1.fsf@concordia.ellerman.id.au>
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

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> It will be used in arch/powerpc/kvm/book3s_hv.c KVM module.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/mce.c |    1 +
>  1 file changed, 1 insertion(+)

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
