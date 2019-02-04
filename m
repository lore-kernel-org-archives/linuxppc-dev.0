Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8998C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:28:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020772177E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A8i24nMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020772177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHpB0sSbzDqGb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:28:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK6d5wzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="A8i24nMT"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK57Nyz9sNB; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=SuhCOASx3SyzoP0b3+2Yh3oHKj7/zNPykwC6N1lmrQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A8i24nMTID7gNA0Cn8XL4x3M8LVTYA5fQtreAjCCqnmQljLRYkomDsDo1AU63sWJe
 V0iyuy7m84pNsrf+/d+TPPdLX5MTzyYD9r+njkK0rj0RezHJm2AZkpY5jGWA1eZkvB
 ioRpPOOz4xXp6/PDtvPxcbs/0a0VeQpBnlz/YkcY=
Date: Mon, 4 Feb 2019 16:26:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 17/19] KVM: PPC: Book3S HV: add get/set accessors for the
 VP XIVE state
Message-ID: <20190204052646.GJ1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Content-Disposition: inline
In-Reply-To: <20190107191006.10648-1-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 08:10:04PM +0100, C=E9dric Le Goater wrote:
> At a VCPU level, the state of the thread context interrupt management
> registers needs to be collected. These registers are cached under the
> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> pulled from the HW thread. An OPAL call retrieves the backup of the
> IPB register in the NVT structure and merges it in the KVM state.
>=20
> The structures of the interface between QEMU and KVM provisions some
> extra room (two u64) for further extensions if more state needs to be
> transferred back to QEMU.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h    |  5 ++
>  arch/powerpc/include/uapi/asm/kvm.h   |  2 +
>  arch/powerpc/kvm/book3s.c             | 24 +++++++++
>  arch/powerpc/kvm/book3s_xive_native.c | 78 +++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 4cc897039485..49c488af168c 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -270,6 +270,7 @@ union kvmppc_one_reg {
>  		u64	addr;
>  		u64	length;
>  	}	vpaval;
> +	u64	xive_timaval[4];
>  };
> =20
>  struct kvmppc_ops {
> @@ -603,6 +604,8 @@ extern void kvmppc_xive_native_cleanup_vcpu(struct kv=
m_vcpu *vcpu);
>  extern void kvmppc_xive_native_init_module(void);
>  extern void kvmppc_xive_native_exit_module(void);
>  extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc=
_one_reg *val);
> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc=
_one_reg *val);
> =20
>  #else
>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 ser=
ver,
> @@ -637,6 +640,8 @@ static inline void kvmppc_xive_native_init_module(voi=
d) { }
>  static inline void kvmppc_xive_native_exit_module(void) { }
>  static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cm=
d)
>  	{ return 0; }
> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union=
 kvmppc_one_reg *val) { return 0; }
> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union=
 kvmppc_one_reg *val) { return -ENOENT; }

IIRC "VP" is the old name for "TCTX".  Since we're using tctx in the
rest of the XIVE code, can we use it here as well.

>  #endif /* CONFIG_KVM_XIVE */
> =20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 95302558ce10..3c958c39a782 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -480,6 +480,8 @@ struct kvm_ppc_cpu_char {
>  #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
>  #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
> =20
> +#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
> +
>  /* Device control API: PPC-specific devices */
>  #define KVM_DEV_MPIC_GRP_MISC		1
>  #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index de7eed191107..5ad658077a35 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -641,6 +641,18 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
>  				*val =3D get_reg_val(id, kvmppc_xics_get_icp(vcpu));
>  			break;
>  #endif /* CONFIG_KVM_XICS */
> +#ifdef CONFIG_KVM_XIVE
> +		case KVM_REG_PPC_VP_STATE:
> +			if (!vcpu->arch.xive_vcpu) {
> +				r =3D -ENXIO;
> +				break;
> +			}
> +			if (xive_enabled())
> +				r =3D kvmppc_xive_native_get_vp(vcpu, val);
> +			else
> +				r =3D -ENXIO;
> +			break;
> +#endif /* CONFIG_KVM_XIVE */
>  		case KVM_REG_PPC_FSCR:
>  			*val =3D get_reg_val(id, vcpu->arch.fscr);
>  			break;
> @@ -714,6 +726,18 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
>  				r =3D kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
>  			break;
>  #endif /* CONFIG_KVM_XICS */
> +#ifdef CONFIG_KVM_XIVE
> +		case KVM_REG_PPC_VP_STATE:
> +			if (!vcpu->arch.xive_vcpu) {
> +				r =3D -ENXIO;
> +				break;
> +			}
> +			if (xive_enabled())
> +				r =3D kvmppc_xive_native_set_vp(vcpu, val);
> +			else
> +				r =3D -ENXIO;
> +			break;
> +#endif /* CONFIG_KVM_XIVE */
>  		case KVM_REG_PPC_FSCR:
>  			vcpu->arch.fscr =3D set_reg_val(id, *val);
>  			break;
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index f4eb71eafc57..1aefb366df0b 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -424,6 +424,84 @@ static int xive_native_validate_queue_size(u32 qsize)
>  	}
>  }
> =20
> +#define TM_IPB_SHIFT 40
> +#define TM_IPB_MASK  (((u64) 0xFF) << TM_IPB_SHIFT)
> +
> +int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_re=
g *val)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	u64 opal_state;
> +	int rc;
> +
> +	if (!kvmppc_xive_enabled(vcpu))
> +		return -EPERM;
> +
> +	if (!xc)
> +		return -ENOENT;
> +
> +	/* Thread context registers. We only care about IPB and CPPR */
> +	val->xive_timaval[0] =3D vcpu->arch.xive_saved_state.w01;
> +
> +	/*
> +	 * Return the OS CAM line to print out the VP identifier in
> +	 * the QEMU monitor. This is not restored.
> +	 */
> +	val->xive_timaval[1] =3D vcpu->arch.xive_cam_word;
> +
> +	/* Get the VP state from OPAL */
> +	rc =3D xive_native_get_vp_state(xc->vp_id, &opal_state);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Capture the backup of IPB register in the NVT structure and
> +	 * merge it in our KVM VP state.
> +	 *
> +	 * TODO: P10 support.
> +	 */
> +	val->xive_timaval[0] |=3D cpu_to_be64(opal_state & TM_IPB_MASK);
> +
> +	pr_devel("%s NSR=3D%02x CPPR=3D%02x IBP=3D%02x PIPR=3D%02x w01=3D%016ll=
x w2=3D%08x opal=3D%016llx\n",
> +		 __func__,
> +		 vcpu->arch.xive_saved_state.nsr,
> +		 vcpu->arch.xive_saved_state.cppr,
> +		 vcpu->arch.xive_saved_state.ipb,
> +		 vcpu->arch.xive_saved_state.pipr,
> +		 vcpu->arch.xive_saved_state.w01,
> +		 (u32) vcpu->arch.xive_cam_word, opal_state);
> +
> +	return 0;
> +}
> +
> +int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_re=
g *val)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	struct kvmppc_xive *xive =3D vcpu->kvm->arch.xive;
> +
> +	pr_devel("%s w01=3D%016llx vp=3D%016llx\n", __func__,
> +		 val->xive_timaval[0], val->xive_timaval[1]);
> +
> +	if (!kvmppc_xive_enabled(vcpu))
> +		return -EPERM;
> +
> +	if (!xc || !xive)
> +		return -ENOENT;
> +
> +	/* We can't update the state of a "pushed" VCPU	 */
> +	if (WARN_ON(vcpu->arch.xive_pushed))
> +		return -EIO;
> +
> +	/* Thread context registers. only restore IPB and CPPR ? */
> +	vcpu->arch.xive_saved_state.w01 =3D val->xive_timaval[0];
> +
> +	/*
> +	 * There is no need to restore the XIVE internal state (IPB
> +	 * stored in the NVT) as the IPB register was merged in KVM VP
> +	 * state.
> +	 */
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long =
irq,
>  					 u64 addr)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXzRYACgkQbDjKyiDZ
s5JibA//RFDvJbbApaUa6duG2EFXzGs6HVwNv8dgZPnLFaN6w94+edGP69CaZ8Ks
W5ogGRQHXTE3Ar14sgGm3AwSBe6B/LltEEza0QyMgab6bmPWuUB0Opdv6vdYPvzp
mjooVxi7uEscx/AKGoki5sl1UrCcwFORiPkFKqQWgQdjZDA4x63xgXjHioLOMjB/
VR41aw4hQi2Mrw7QZJMxRvqXccEvOAVN6AE0dNGO/bVd0wyQ+xR4B87/MvtecBN1
Ft5TP++MdUelKRP3KbvJoNyrr+mbrXXOJGOcWeled/+LXeWM04mdJn5qFZyxYP2S
3zDZAenbOBiX7EoGgMg37CSo/zLSEdbzpqCjVaInEVRUdf3+2KpU3++Eyai7/GCO
plyPSBw+2f0kIFe4nmzpKYlVxv4BAJdoYFaaHcxN662UKMbVJNfMbya6z+Wj3PZA
E4txsf7sVtgmMBGFLvxGoAMRPebJ2GFWOcyiQo0GB2RxEvCe+StYRTfS2VlwUeK3
UM8VEFYBb9xw9faDHkHJiwvI9hDgeoltuCI2pkLkBCePOQN8wW75y1eektdMQ+mm
3aiVt/oGM2Ix+YapCpC2zigRaFVkQgQgglFD45sDPHRnJ1O31GtmKAA0EMqsTSYe
g4FRXt4ROM7Hse0eF1FqWVhVPdZDqi8o4R1hQAUZkqAsjEinnok=
=sq+W
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--
