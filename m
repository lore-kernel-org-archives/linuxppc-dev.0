Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 11B7CDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 11:45:42 +1000 (EST)
Date: Thu, 24 Jul 2008 11:45:39 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: ehrhardt@linux.vnet.ibm.com
Subject: Re: [PATCH 3/6] kvmppc: add hypercall infrastructure - guest part
Message-ID: <20080724014538.GJ20457@bakeyournoodle.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1216802207-32675-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 10:36:44AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

Hi Christian,
> 
> This adds the guest portion of the hypercall infrastructure, basically an
> illegal instruction with a defined layout.
> See http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI for more detail
> on the hypercall ABI for powerpc.
> 
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> ---
> 
> [diffstat]
>  kvm_para.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> [diff]
> diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
> --- a/include/asm-powerpc/kvm_para.h
> +++ b/include/asm-powerpc/kvm_para.h
> @@ -25,6 +25,8 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/of.h>
> +
> +#define KVM_HYPERCALL_BIN 0x03ffffff

Ummm didn't you add this in patch 2 of 6?

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
