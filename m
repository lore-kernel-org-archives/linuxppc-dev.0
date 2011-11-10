Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F35FEB6F90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 04:11:53 +1100 (EST)
Message-ID: <4EBC05D2.1020201@suse.de>
Date: Thu, 10 Nov 2011 18:11:46 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc/kvm: annotate kvm_rma_init as __init
References: <20111107232956.GA20208@us.ibm.com>
In-Reply-To: <20111107232956.GA20208@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 12:29 AM, Nishanth Aravamudan wrote:
> kvm_rma_init() is only called at boot-time, by setup_arch, which is also __init.
>
> Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>

Thanks, applied to kvm-ppc-next.


Alex

> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index d431203..73fdcc1 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -85,7 +85,7 @@ static inline int lpcr_rmls(unsigned long rma_size)
>    * to allocate contiguous physical memory for the real memory
>    * areas for guests.
>    */
> -void kvm_rma_init(void)
> +void __init kvm_rma_init(void)
>   {
>   	unsigned long i;
>   	unsigned long j, npages;
>
