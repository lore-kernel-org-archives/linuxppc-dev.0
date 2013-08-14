Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFF8C2C0168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 10:51:25 +1000 (EST)
Message-ID: <1376441474.4255.39.camel@pasglop>
Subject: Re: [PATCH 02/10] KVM: PPC: reserve a capability number for
 multitce support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Wed, 14 Aug 2013 10:51:14 +1000
In-Reply-To: <1375332272-22176-3-git-send-email-aik@ozlabs.ru>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-3-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-01 at 14:44 +1000, Alexey Kardashevskiy wrote:
> This is to reserve a capablity number for upcoming support
> of H_PUT_TCE_INDIRECT and H_STUFF_TCE pseries hypercalls
> which support mulptiple DMA map/unmap operations per one call.

Gleb, any chance you can put this (and the next one) into a tree to
"lock in" the numbers ?

I've been wanting to apply the whole series to powerpc-next, that's
stuff has been simmering for way too long and is in a good enough shape
imho, but I need the capabilities and ioctl numbers locked in your tree
first.

Cheers,
Ben.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> 2013/07/16:
> * changed the number
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index acccd08..99c2533 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_PPC_RTAS 91
>  #define KVM_CAP_IRQ_XICS 92
>  #define KVM_CAP_ARM_EL1_32BIT 93
> +#define KVM_CAP_SPAPR_MULTITCE 94
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
