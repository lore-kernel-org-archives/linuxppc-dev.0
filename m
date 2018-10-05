Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FD8C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:05:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA2920875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="db16rCNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA2920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHlH0JkDzF3KB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:05:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="db16rCNC";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjW6trqzF3Jf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="db16rCNC"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjW663pz9sj8; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjW5ktnz9sB7; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713151;
 bh=oOGjbZ0t4ZSCryoRO7wd6WZy9reuAOJHnPERLapYSPc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=db16rCNCYq9Pr3TBdHWZZ07j7lXgGnBug2wNKtEpSgm3TxEPkK+G6jy6/y3H6sBHo
 b4P5fnUC9aG89ifIXmN2EtD9XMkryBC0OFNwKxUZLpfnSwhQvpCSgnjEM75Zmxwszi
 r+kCrm5XgRvDOX/gxLpB9ZpIypC3c8cUmKogtY2s=
Date: Fri, 5 Oct 2018 13:06:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 32/32] KVM: PPC: Book3S HV: Add a VM capability to
 enable nested virtualization
Message-ID: <20181005030642.GH7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-33-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <1538654169-15602-33-git-send-email-paulus@ozlabs.org>
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


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 09:56:09PM +1000, Paul Mackerras wrote:
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
>  arch/powerpc/kvm/book3s_hv.c       | 19 +++++++++++++++++++
>  arch/powerpc/kvm/powerpc.c         | 12 ++++++++++++
>  include/uapi/linux/kvm.h           |  1 +
>  5 files changed, 47 insertions(+)
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
> index 7f89b22..d3cc013 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -118,6 +118,11 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &=
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
>  /* If set, the threads on each CPU core have to be in the same MMU mode =
*/
>  static bool no_mixing_hpt_and_radix;
> =20
> @@ -5165,6 +5170,19 @@ static int kvmhv_configure_mmu(struct kvm *kvm, st=
ruct kvm_ppc_mmuv3_cfg *cfg)
>  	return err;
>  }
> =20
> +static int kvmhv_enable_nested(struct kvm *kvm, bool enable)
> +{
> +	if (!nested)
> +		return -EPERM;
> +	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +		return -ENODEV;
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
> @@ -5204,6 +5222,7 @@ static struct kvmppc_ops kvm_ops_hv =3D {
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

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu21UIACgkQbDjKyiDZ
s5IYew//fB9XEru/yMM5pj1saMqjrMXJssIRszzvGLZoxoNajSWnD05UaDfSt79J
WFTR5otvCRzAenf6kwgZIsWWxzaFJ8D6ow02vAdsVmad998XW6qkHG3OiiMM4vMM
oe63/xO8x2YrX2M80P9nB1Ldkk7kgphwM1VfGlc2MsR0PkAhmODG6GdqynoIJazb
CyTSEqjrcfunGUWFL1euJo8osfEwUn8WPTrXoK237KMk3/V7sLwZwi24dYkNsgB/
RKnoiW2y8ZO6vEoC70M1fOcxjXL2saQH95TYhPl0SYKpfRmz1tWAIwCWzPvrR/ma
1w/kvf1q99kKP6BSQjX2ICntCakQWwKFgtCWABSKnlgAExmYU9ZTagR4RBu9+31J
6o1mk8gwG2QrzZ9sTByEUFPjrY3oF956Lm+zaEGjWh4nforjkja8/9r0qnEjWCLz
S1Wm/zU0BzTlvF2jhUODiUQ0HelduVh/jL/2XLClV7Ta29XYOH3iIR2gDPBFaZgE
xwKP4I64x4N6CAPVAWaxdwjxMjr52d+GbplHXdRT3s7O1rRQbEkPTtddwO0wnfOl
VEq8Aycrj/FBQSu6i/0xkRHjl1OIS64i/sACP5ZhN5oe3CN1LXehjF71JFOMvi5f
oZJwSwsEGCiCFJ2jehNGxxKBlKRCJ3riksK9fQg2VxKWr0sVx3A=
=ciVQ
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
