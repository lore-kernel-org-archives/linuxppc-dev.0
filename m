Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E12802C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 22:24:56 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Wed, 6 Nov 2013 12:24:49 +0100
Message-Id: <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.11.2013, at 08:42, Liu Ping Fan <kernelfans@gmail.com> wrote:

> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Patch description missing.

Please add Paul's ack in the next revision of this patch :).


Alex

> ---
> arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 28160ac..7682837 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -731,7 +731,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> 	lock_rmap(rmap);
>=20
> 	/* Check if we might have been invalidated; let the guest retry =
if so */
> -	ret =3D RESUME_GUEST;
> 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
> 		unlock_rmap(rmap);
> 		goto out_unlock;
> --=20
> 1.8.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
