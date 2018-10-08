Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B02C67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:01:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D113920C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J2fACr2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D113920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tf7d6pHdzF3Dc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:01:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J2fACr2w";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf1z5PcmzF3BQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="J2fACr2w"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf1z4RHmzB4Mm; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf1z3fhyz9sRp; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046599;
 bh=K1b7FOgQhC/Id4/ixBn49jz9ZB0kZtE5UjvjI8pi7KQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J2fACr2wJJz+UjgVavi+W4PGBHELcmPD+9re7Uz/YJxuShQF43XuoQZGfJ6SntDaH
 yq/R8OwievZdPnYI7gOpuKi/yHuqkJvV7y7MWkpByJGmJkgLeiwcQ3H2F/gUyDIVsX
 vp6gaETmmHky2f65smUb/sR5s3hIQ7u26Pgk9hxI=
Date: Tue, 9 Oct 2018 10:34:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 32/33] KVM: PPC: Book3S HV: Add a VM capability to
 enable nested virtualization
Message-ID: <20181008233408.GC7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-33-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qXCixuLMVvZDruUh"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-33-git-send-email-paulus@ozlabs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:31:18PM +1100, Paul Mackerras wrote:
> With this, userspace can enable a KVM-HV guest to run nested guests
> under it.
>=20
> The administrator can control whether any nested guests can be run;
> setting the "nested" module parameter to false prevents any guests
> becoming nested hypervisors (that is, any attempt to enable the nested
> capability on a guest will fail).  Guests which are already nested
> hypervisors will continue to be so.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  Documentation/virtual/kvm/api.txt  | 14 ++++++++++++++
>  arch/powerpc/include/asm/kvm_ppc.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c       | 39 +++++++++++++++++++++++++++++---=
------
>  arch/powerpc/kvm/powerpc.c         | 12 ++++++++++++
>  include/uapi/linux/kvm.h           |  1 +
>  5 files changed, 58 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index 2f5f9b7..fde48b6 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4532,6 +4532,20 @@ With this capability, a guest may read the MSR_PLA=
TFORM_INFO MSR. Otherwise,
>  a #GP would be raised when the guest tries to access. Currently, this
>  capability does not enable write permissions of this MSR for the guest.
> =20
> +7.16 KVM_CAP_PPC_NESTED_HV
> +
> +Architectures: ppc
> +Parameters: none
> +Returns: 0 on success, -EINVAL when the implementation doesn't support
> +	 nested-HV virtualization.
> +
> +HV-KVM on POWER9 and later systems allows for "nested-HV"
> +virtualization, which provides a way for a guest VM to run guests that
> +can run using the CPU's supervisor mode (privileged non-hypervisor
> +state).  Enabling this capability on a VM depends on the CPU having
> +the necessary functionality and on the facility being enabled with a
> +kvm-hv module parameter.
> +
>  8. Other capabilities.
>  ----------------------
> =20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 245e564..b3796bd 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -327,6 +327,7 @@ struct kvmppc_ops {
>  	int (*set_smt_mode)(struct kvm *kvm, unsigned long mode,
>  			    unsigned long flags);
>  	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
> +	int (*enable_nested)(struct kvm *kvm);
>  };
> =20
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 152bf75..fa61647 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -118,6 +118,16 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &=
h_ipi_redirect, 0644);
>  MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host c=
ore");
>  #endif
> =20
> +/* If set, guests are allowed to create and control nested guests */
> +static bool nested =3D true;
> +module_param(nested, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(nested, "Enable nested virtualization (only on POWER9)"=
);
> +
> +static inline bool nesting_enabled(struct kvm *kvm)
> +{
> +	return kvm->arch.nested_enable && kvm_is_radix(kvm);
> +}
> +
>  /* If set, the threads on each CPU core have to be in the same MMU mode =
*/
>  static bool no_mixing_hpt_and_radix;
> =20
> @@ -959,12 +969,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
> =20
>  	case H_SET_PARTITION_TABLE:
>  		ret =3D H_FUNCTION;
> -		if (vcpu->kvm->arch.nested_enable)
> +		if (nesting_enabled(vcpu->kvm))
>  			ret =3D kvmhv_set_partition_table(vcpu);
>  		break;
>  	case H_ENTER_NESTED:
>  		ret =3D H_FUNCTION;
> -		if (!vcpu->kvm->arch.nested_enable)
> +		if (!nesting_enabled(vcpu->kvm))
>  			break;
>  		ret =3D kvmhv_enter_nested_guest(vcpu);
>  		if (ret =3D=3D H_INTERRUPT) {
> @@ -974,9 +984,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  		break;
>  	case H_TLB_INVALIDATE:
>  		ret =3D H_FUNCTION;
> -		if (!vcpu->kvm->arch.nested_enable)
> -			break;
> -		ret =3D kvmhv_do_nested_tlbie(vcpu);
> +		if (nesting_enabled(vcpu->kvm))
> +			ret =3D kvmhv_do_nested_tlbie(vcpu);
>  		break;
> =20
>  	default:
> @@ -4496,10 +4505,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcp=
u *vcpu)
>  /* Must be called with kvm->lock held and mmu_ready =3D 0 and no vcpus r=
unning */
>  int kvmppc_switch_mmu_to_hpt(struct kvm *kvm)
>  {
> -	if (kvm->arch.nested_enable) {
> -		kvm->arch.nested_enable =3D false;
> +	if (nesting_enabled(kvm))
>  		kvmhv_release_all_nested(kvm);
> -	}
>  	kvmppc_free_radix(kvm);
>  	kvmppc_update_lpcr(kvm, LPCR_VPM1,
>  			   LPCR_VPM1 | LPCR_UPRT | LPCR_GTSE | LPCR_HR);
> @@ -4776,7 +4783,7 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *k=
vm)
> =20
>  	/* Perform global invalidation and return lpid to the pool */
>  	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> -		if (kvm->arch.nested_enable)
> +		if (nesting_enabled(kvm))
>  			kvmhv_release_all_nested(kvm);
>  		kvm->arch.process_table =3D 0;
>  		kvmhv_set_ptbl_entry(kvm->arch.lpid, 0, 0);
> @@ -5169,6 +5176,19 @@ static int kvmhv_configure_mmu(struct kvm *kvm, st=
ruct kvm_ppc_mmuv3_cfg *cfg)
>  	return err;
>  }
> =20
> +static int kvmhv_enable_nested(struct kvm *kvm)
> +{
> +	if (!nested)
> +		return -EPERM;
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		return -ENODEV;
> +
> +	/* kvm =3D=3D NULL means the caller is testing if the capability exists=
 */
> +	if (kvm)
> +		kvm->arch.nested_enable =3D true;
> +	return 0;
> +}
> +
>  static struct kvmppc_ops kvm_ops_hv =3D {
>  	.get_sregs =3D kvm_arch_vcpu_ioctl_get_sregs_hv,
>  	.set_sregs =3D kvm_arch_vcpu_ioctl_set_sregs_hv,
> @@ -5208,6 +5228,7 @@ static struct kvmppc_ops kvm_ops_hv =3D {
>  	.configure_mmu =3D kvmhv_configure_mmu,
>  	.get_rmmu_info =3D kvmhv_get_rmmu_info,
>  	.set_smt_mode =3D kvmhv_set_smt_mode,
> +	.enable_nested =3D kvmhv_enable_nested,
>  };
> =20
>  static int kvm_init_subcore_bitmap(void)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 1f4b128..2869a29 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -597,6 +597,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  		r =3D !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300) &&
>  		       cpu_has_feature(CPU_FTR_HVMODE));
>  		break;
> +	case KVM_CAP_PPC_NESTED_HV:
> +		r =3D !!(hv_enabled && kvmppc_hv_ops->enable_nested &&
> +		       !kvmppc_hv_ops->enable_nested(NULL));
> +		break;
>  #endif
>  	case KVM_CAP_SYNC_MMU:
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> @@ -2115,6 +2119,14 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			r =3D kvm->arch.kvm_ops->set_smt_mode(kvm, mode, flags);
>  		break;
>  	}
> +
> +	case KVM_CAP_PPC_NESTED_HV:
> +		r =3D -EINVAL;
> +		if (!is_kvmppc_hv_enabled(kvm) ||
> +		    !kvm->arch.kvm_ops->enable_nested)
> +			break;
> +		r =3D kvm->arch.kvm_ops->enable_nested(kvm);
> +		break;
>  #endif
>  	default:
>  		r =3D -EINVAL;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 251be35..d9cec6b 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -953,6 +953,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_NESTED_STATE 157
>  #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>  #define KVM_CAP_MSR_PLATFORM_INFO 159
> +#define KVM_CAP_PPC_NESTED_HV 160
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qXCixuLMVvZDruUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu76W8ACgkQbDjKyiDZ
s5Lv1Q//U0Z3Qf380ncLo97rt7FvpABCV+hW1vLbQLp+XVLjR9qTPPdhPxTfVzwj
75pWr6fJQfA66pQL+9ft/DGcqtmhT9Ac4ihztqR5iL5Y85h1zM9CftN6dE9HD/6Z
IjTyesM7AFLpcnqlhB94XDMCAYYCFJxldZQ/5zmAG6o2+MtTOe+CSmruFdesNZTD
BnLB+MkkhSErzRmwhloD7ydVkrjL5SidoeU6XCUGy2qmB5fxXJamjZpBgmfpbOMY
PjiOCze47e06faBIeLKenyxDj/i9JQeZn1h/MzOlq/mlE2NYOIQ1NeH5uRPhwHXn
by8Xxmaz7lDyGQSqOccpJ4ECNoIKOCaEoTF8k/RX1t/0W+V/ZRCbU1bOON8w51wl
zslkcQFcW3vRTTwA90Iqwqee6an3QZn2G765aHWbU++HRzDHI5zIcXt5L7ViiLnb
sTL/uqb8dQ2RfVAh2PZBmxBm8ZUD7wh+dUVsVy8yAe4OaCmGSxCFJhbryh3/daaC
Zfu3LqFQNLpV6cPAmo9eTc76wPOS5y/r/C9gRL8VD+VHjtzR8ob634SOzgiTkk5/
uaXy8uIgwBajIu6UC2RwIl6nm22/8NryTZxxOZSlbDWNyr69X5RkLPhf22HXWnPk
2uVjnqh1tP93COIPys2PsAHHxeLZcOpsVmEzJqegxeGILeahLWs=
=Iq4q
-----END PGP SIGNATURE-----

--qXCixuLMVvZDruUh--
