Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA1C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:24:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B632D20652
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S8PEe2r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B632D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5bG4ZGzzF3G3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:24:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S8PEe2r+";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X262KZzF3BG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="S8PEe2r+"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X25301zB3sq; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X24TwtzB2xZ; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=DJuf++Vl7tWavwXCVSpRzJlKb6+ZMEjMRFpqwqftxZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S8PEe2r+kVxSHPedo0Uw/uATAMf72e9aBWfNAyM/wvGCJohBs1nKRDwWoKy5hTS/O
 XdFnpGjI1/fPnY0ioUjERLc3KctxA1azMXwKm4WnHG+gOAY2iUF7CCylJjNpqrfit7
 4gqCpBMWeclyhDqxAbtIpzRAZJr7du/zoMe57Ils=
Date: Wed, 3 Oct 2018 16:07:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 28/33] KVM: PPC: Book3S HV: Sanitise hv_regs on nested
 guest entry
Message-ID: <20181003060736.GU1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-29-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GAoked8QSizNecZ5"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-29-git-send-email-paulus@ozlabs.org>
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


--GAoked8QSizNecZ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:27PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> restore_hv_regs() is used to copy the hv_regs L1 wants to set to run the
> nested (L2) guest into the vcpu structure. We need to sanitise these
> values to ensure we don't let the L1 guest hypervisor do things we don't
> want it to.
>=20
> We don't let data address watchpoints or completed instruction address
> breakpoints be set to match in hypervisor state.
>=20
> We also don't let L1 enable features in the hypervisor facility status
> and control register (HFSCR) for L2 which we have disabled for L1. That
> is L2 will get the subset of features which the L0 hypervisor has
> enabled for L1 and the features L1 wants to enable for L2. This could
> mean we give L1 a hypervisor facility unavailable interrupt for a
> facility it thinks it has enabled, however it shouldn't have enabled a
> facility it itself doesn't have for the L2 guest.
>=20
> We sanitise the registers when copying in the L2 hv_regs. We don't need
> to sanitise when copying back the L1 hv_regs since these shouldn't be
> able to contain invalid values as they're just what was copied out.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/reg.h      |  1 +
>  arch/powerpc/kvm/book3s_hv_nested.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index 9c42abf..47489f6 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -415,6 +415,7 @@
>  #define   HFSCR_DSCR	__MASK(FSCR_DSCR_LG)
>  #define   HFSCR_VECVSX	__MASK(FSCR_VECVSX_LG)
>  #define   HFSCR_FP	__MASK(FSCR_FP_LG)
> +#define   HFSCR_INTR_CAUSE (ASM_CONST(0xFF) << 56)	/* interrupt cause */
>  #define SPRN_TAR	0x32f	/* Target Address Register */
>  #define SPRN_LPCR	0x13E	/* LPAR Control Register */
>  #define   LPCR_VPM0		ASM_CONST(0x8000000000000000)
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index 7656cb3..7b1088a 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -86,6 +86,22 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu=
, int trap,
>  	}
>  }
> =20
> +static void sanitise_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_stat=
e *hr)
> +{
> +	/*
> +	 * Don't let L1 enable features for L2 which we've disabled for L1,
> +	 * but preserve the interrupt cause field.
> +	 */
> +	hr->hfscr &=3D (HFSCR_INTR_CAUSE | vcpu->arch.hfscr);
> +
> +	/* Don't let data address watchpoint match in hypervisor state */
> +	hr->dawrx0 &=3D ~DAWRX_HYP;
> +
> +	/* Don't let completed instruction address breakpt match in HV state */
> +	if ((hr->ciabr & CIABR_PRIV) =3D=3D CIABR_PRIV_HYPER)
> +		hr->ciabr &=3D ~CIABR_PRIV;
> +}
> +
>  static void restore_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state=
 *hr)
>  {
>  	struct kvmppc_vcore *vc =3D vcpu->arch.vcore;
> @@ -198,6 +214,7 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
>  	mask =3D LPCR_DPFD | LPCR_ILE | LPCR_TC | LPCR_AIL | LPCR_LD |
>  		LPCR_LPES | LPCR_MER;
>  	lpcr =3D (vc->lpcr & ~mask) | (l2_hv.lpcr & mask);
> +	sanitise_hv_regs(vcpu, &l2_hv);
>  	restore_hv_regs(vcpu, &l2_hv);
> =20
>  	vcpu->arch.ret =3D RESUME_GUEST;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GAoked8QSizNecZ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0XKMACgkQbDjKyiDZ
s5LWFA//TsPiGp8ItmLNehs/iUTtvZE9Es09k61dQr7NkGqnIZLS7gnkD73oQgnf
S0fMkUH78wmFVrdJWkPG521DKHVhyMUJnGcrWyZ8RlKKjRuQqxAzg/NOPoxiaAwh
OW61oG62gKIbLmaJba0bkYB4WcHxTo+TgS6XTSR2/ZuqmqN68AoPw/CNBVXNbSmn
udw6FwbcwqP6rhtVzk+eW90bgFo1/qD8FXHKJN9ObCDLo2j/s34gUqeYYbxYhbkm
uCNBrQbh7Qjv1JDEmhsvoDUH3nY52AeFeNT7jq8vl0FgwPL6kmXcvtGlUAztnNnT
4s9atAxSQ4bYQmn+MkJceCx6g7d62ginikn8A9PjfnuT4YQ6A+5KZdcdu6VI6xEy
HHITUFa3x9jXXdRSby6A6ljYfUP9aYZg4MwiV9T/IdlHZhUPYDF2azkXQtBQu3A4
eTGeHZrfWsqJKibLEzS7K2pvb+/l1IdMuNmZ7YafYFZahth4RhLQn0IvFCinkErD
E8nu7q6YgWi6niUClmNANIZZXAR6sPPvD7BK7NjCSd6KVywx+zocZ5k+UIw4Zo+J
mJKmJ/W5e52QKrhZLJ4xlhECUa16MydbX38Y2DmpwUuZuIzNVrdrZ/M5iHJm1sjG
UVXf2J/SYfGzKr+iSb+L8aSI3vwwFdLvkL4pggY+axdJoar1wpo=
=NBQA
-----END PGP SIGNATURE-----

--GAoked8QSizNecZ5--
