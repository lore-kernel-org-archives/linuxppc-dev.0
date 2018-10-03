Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C6CC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759BA20652
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vinpe48j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759BA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5dy1NzJzF3JD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vinpe48j";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X25jSNzF3BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Vinpe48j"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X245tpzB2xn; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X23JmFzB2xQ; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=QdYDtIaZu4lMMuO2q5pAKYxCgYkLEFecmHcAS7lCBxw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vinpe48jq6jwCObo94bQ/VXqyaMdSyHbLANUNLvJEAPF0W3VvXmV/z8f7bpepgmgd
 MCBMzwQikM2mq2V10hawKENeq6/ytfQ7TiHc9e221RYPwEO/5L1dQmtBMi8gkA2D9y
 W9lrEV3PRHjMaeGRkNRpwEPuv8qxBScsiCeGHWv0=
Date: Wed, 3 Oct 2018 16:21:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 33/33] KVM: PPC: Book3S HV: Add a VM capability to
 enable nested virtualization
Message-ID: <20181003062144.GY1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-34-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tpZe61tYkA9f+p/0"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-34-git-send-email-paulus@ozlabs.org>
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


--tpZe61tYkA9f+p/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:32PM +1000, Paul Mackerras wrote:
> With this, userspace can enable a KVM-HV guest to run nested guests
> under it.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  Documentation/virtual/kvm/api.txt  | 14 ++++++++++++++
>  arch/powerpc/include/asm/kvm_ppc.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c       | 17 +++++++++++++++++
>  arch/powerpc/kvm/powerpc.c         | 12 ++++++++++++
>  include/uapi/linux/kvm.h           |  1 +
>  5 files changed, 45 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index 017d851..a2d4832 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4522,6 +4522,20 @@ hpage module parameter is not set to 1, -EINVAL is=
 returned.
>  While it is generally possible to create a huge page backed VM without
>  this capability, the VM will not be able to run.
> =20
> +7.15 KVM_CAP_PPC_NESTED_HV
> +
> +Architectures: ppc
> +Parameters: enable flag (0 to disable, non-zero to enable)
> +Returns: 0 on success, -EINVAL when the implementation doesn't support
> +nested-HV virtualization.
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
> index 245e564..80f0091 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -327,6 +327,7 @@ struct kvmppc_ops {
>  	int (*set_smt_mode)(struct kvm *kvm, unsigned long mode,
>  			    unsigned long flags);
>  	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
> +	int (*enable_nested)(struct kvm *kvm, bool enable);
>  };
> =20
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 196bff1..a5b3862 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -118,6 +118,11 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &=
h_ipi_redirect, 0644);
>  MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host c=
ore");
>  #endif
> =20
> +/* If set, guests are allowed to create and control nested guests */
> +static bool enable_nested =3D true;
> +module_param(enable_nested, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(enable_nested, "Enable nested virtualization (only on P=
OWER9)");

I'd suggest calling the module parameter just "nested" to match x86.

>  /* If set, the threads on each CPU core have to be in the same MMU mode =
*/
>  static bool no_mixing_hpt_and_radix;
> =20
> @@ -5188,6 +5193,17 @@ static int kvmhv_configure_mmu(struct kvm *kvm, st=
ruct kvm_ppc_mmuv3_cfg *cfg)
>  	return err;
>  }
> =20
> +static int kvmhv_enable_nested(struct kvm *kvm, bool enable)
> +{
> +	if (!(enable_nested && cpu_has_feature(CPU_FTR_ARCH_300)))
> +		return -EINVAL;

Maybe EPERM, rather than EINVAL.  There's nothing invalid about the
ioctl() parameters - we just can't do what they want.

> +
> +	/* kvm =3D=3D NULL means the caller is testing if the capability exists=
 */
> +	if (kvm)
> +		kvm->arch.nested_enable =3D enable;
> +	return 0;
> +}
> +
>  static struct kvmppc_ops kvm_ops_hv =3D {
>  	.get_sregs =3D kvm_arch_vcpu_ioctl_get_sregs_hv,
>  	.set_sregs =3D kvm_arch_vcpu_ioctl_set_sregs_hv,
> @@ -5227,6 +5243,7 @@ static struct kvmppc_ops kvm_ops_hv =3D {
>  	.configure_mmu =3D kvmhv_configure_mmu,
>  	.get_rmmu_info =3D kvmhv_get_rmmu_info,
>  	.set_smt_mode =3D kvmhv_set_smt_mode,
> +	.enable_nested =3D kvmhv_enable_nested,
>  };
> =20
>  static int kvm_init_subcore_bitmap(void)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index eba5756..449ae1d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -596,6 +596,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  	case KVM_CAP_PPC_MMU_HASH_V3:
>  		r =3D !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300));
>  		break;
> +	case KVM_CAP_PPC_NESTED_HV:
> +		r =3D !!(hv_enabled && kvmppc_hv_ops->enable_nested &&
> +		       !kvmppc_hv_ops->enable_nested(NULL, false));
> +		break;
>  #endif
>  	case KVM_CAP_SYNC_MMU:
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> @@ -2114,6 +2118,14 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			r =3D kvm->arch.kvm_ops->set_smt_mode(kvm, mode, flags);
>  		break;
>  	}
> +
> +	case KVM_CAP_PPC_NESTED_HV:
> +		r =3D -EINVAL;
> +		if (!is_kvmppc_hv_enabled(kvm) ||
> +		    !kvm->arch.kvm_ops->enable_nested)
> +			break;
> +		r =3D kvm->arch.kvm_ops->enable_nested(kvm, !!cap->args[0]);
> +		break;
>  #endif
>  	default:
>  		r =3D -EINVAL;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 07548de..a6d5a46 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -952,6 +952,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_HPAGE_1M 156
>  #define KVM_CAP_NESTED_STATE 157
>  #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
> +#define KVM_CAP_PPC_NESTED_HV 160
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tpZe61tYkA9f+p/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0X/gACgkQbDjKyiDZ
s5KF4w//SlUvvvmpAhS1P3jB62BklYr3kD4gGTGFCzufYOsWptwic2L6HMehUW8A
0viJ7fDjpkrT2gLFVRW9KbyrXDxU6qVKmUvjVsmzjHwCF6JJb1CUI4NuN+hKD+m1
ht6XQHHCT7eN8r+dcsvxc7aviZ34bBn/h1e6a+ibnFb7hnJvxMADh2LsruTZ6sly
Malpd9VmUscm8PQ5cS30Y5vID6+ocQ6OK4235Dnfk7GtgmCNe0FkUtnQZ36lGb2g
gMuSiTZfslRaV1C5foMI4QKMwT02qVs+0YJRM+rK6xf4g0W7pPT6C9S8xWa04fJO
R19zebI4eunVhKTHHXdEAYSy7hgZiHJw4E2XgfIcrMctcwZ077OjfLtgxS43sYLf
AR2CCP6NzeNXAVS1HDDhUIqy7sJTinPQIgBYcI+Lx/dgI1Dx2sfeMEZcchhOOSmP
yIfP1azhtdzhsxf0lVmYxjwvS4l5Y5fUUTmznJvTSvOn9S3YLMJZXARhxpX61FEo
H9nTgsgo4QPQEYV6yFi7e12/zvNUjh78J2ceZgQsBz88bVoC96qiU2aqS9AJibmS
I/p2mHxPAtnfxFnm0kquvLzLsK6tcFW7L3uHz92KZEyNjzkIQmZsbXYprzLDuK26
2EoXDnnU1cWp9HxKK8QuCh7X72qvE2gUJtvb0IFvo13E0WcRNDI=
=/9Rs
-----END PGP SIGNATURE-----

--tpZe61tYkA9f+p/0--
