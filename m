Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F0FB1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 17:44:21 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 02:44:18 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 12247C90042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:33:00 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R6iGwU4522406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 06:44:16 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R6iGoX001750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:44:16 -0400
Message-ID: <544DE9B0.2050500@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 12:14:00 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 11/11] powerpc: kvm: Kconfig add an option for enabling
 secondary hwthread
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-12-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-12-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2014 01:00 AM, kernelfans@gmail.com wrote:
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 602eb51..de38566 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -93,6 +93,10 @@ config KVM_BOOK3S_64_HV
>  
>  	  If unsure, say N.
>  
> +config KVMPPC_ENABLE_SECONDARY
> +	tristate "KVM support for running on secondary hwthread in host"
> +	depends on KVM_BOOK3S_64_HV

This patch is required ontop of all the rest :) The top patches won't
compile without this one. Every patch in the patchset should be able to
compile successfully without the aid of the patches that come after it.

Regards
Preeti U Murthy
