Return-Path: <paulus@ozlabs.org>
Date: Wed, 6 Nov 2013 16:04:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
Message-ID: <20131106050457.GE14842@drongo>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 03:42:44PM +0800, Liu Ping Fan wrote:
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 28160ac..7682837 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -731,7 +731,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  	lock_rmap(rmap);
>  
>  	/* Check if we might have been invalidated; let the guest retry if so */
> -	ret = RESUME_GUEST;
>  	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
>  		unlock_rmap(rmap);
>  		goto out_unlock;

Acked-by: Paul Mackerras <paulus@samba.org>
