Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA8C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 03:47:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B662070B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 03:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W9tWsGra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B662070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZFSH3RlkzDqcK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 14:47:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZFQQ5DKMzDqWp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 14:45:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="W9tWsGra"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ZFQQ3HJ3z9sD9; Wed,  9 Jan 2019 14:45:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1547005534;
 bh=otONaWUFYh8eO2uygJUIY4Bu3IuJNUpmRxuGV/UKHUo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W9tWsGrakV/bQzvAjbMDK7Flud6kGOWr7L8/ARLs1VZwR/Gt/F6y8Ki13A7Ed2Gnr
 jELahNJAcYEuzb3MiodT/XTFM403c2L8pxnJzhKW1BnYQw+tkqu90uxzVrpgVDaRKv
 xFSnK2kzrA+SvK/uXWwqLNPLau31eJsxkfZ30ggI=
Date: Wed, 9 Jan 2019 14:33:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 01/19] powerpc/xive: export flags for the XIVE native
 exploitation mode hcalls
Message-ID: <20190109033320.GB6682@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-2-clg@kaod.org>
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


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:13PM +0100, C=E9dric Le Goater wrote:
> These flags are shared between Linux/KVM implementing the hypervisor
> calls for the XIVE native exploitation mode and the driver for the
> sPAPR guests.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/xive.h  | 23 +++++++++++++++++++++++
>  arch/powerpc/sysdev/xive/spapr.c | 28 ++++++++--------------------
>  2 files changed, 31 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index 3c704f5dd3ae..32f033bfbf42 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -93,6 +93,29 @@ extern void xive_flush_interrupt(void);
>  /* xmon hook */
>  extern void xmon_xive_do_dump(int cpu);
> =20
> +/*
> + * Hcall flags shared by the sPAPR backend and KVM
> + */
> +
> +/* H_INT_GET_SOURCE_INFO */
> +#define XIVE_SPAPR_SRC_H_INT_ESB	PPC_BIT(60)
> +#define XIVE_SPAPR_SRC_LSI		PPC_BIT(61)
> +#define XIVE_SPAPR_SRC_TRIGGER		PPC_BIT(62)
> +#define XIVE_SPAPR_SRC_STORE_EOI	PPC_BIT(63)
> +
> +/* H_INT_SET_SOURCE_CONFIG */
> +#define XIVE_SPAPR_SRC_SET_EISN		PPC_BIT(62)
> +#define XIVE_SPAPR_SRC_MASK		PPC_BIT(63) /* unused */
> +
> +/* H_INT_SET_QUEUE_CONFIG */
> +#define XIVE_SPAPR_EQ_ALWAYS_NOTIFY	PPC_BIT(63)
> +
> +/* H_INT_SET_QUEUE_CONFIG */
> +#define XIVE_SPAPR_EQ_DEBUG		PPC_BIT(63)
> +
> +/* H_INT_ESB */
> +#define XIVE_SPAPR_ESB_STORE		PPC_BIT(63)
> +
>  /* APIs used by KVM */
>  extern u32 xive_native_default_eq_shift(void);
>  extern u32 xive_native_alloc_vp_block(u32 max_vcpus);
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index 575db3b06a6b..730284f838c8 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -184,9 +184,6 @@ static long plpar_int_get_source_info(unsigned long f=
lags,
>  	return 0;
>  }
> =20
> -#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
> -#define XIVE_SRC_MASK     (1ull << (63 - 63)) /* unused */
> -
>  static long plpar_int_set_source_config(unsigned long flags,
>  					unsigned long lisn,
>  					unsigned long target,
> @@ -243,8 +240,6 @@ static long plpar_int_get_queue_info(unsigned long fl=
ags,
>  	return 0;
>  }
> =20
> -#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
> -
>  static long plpar_int_set_queue_config(unsigned long flags,
>  				       unsigned long target,
>  				       unsigned long priority,
> @@ -286,8 +281,6 @@ static long plpar_int_sync(unsigned long flags, unsig=
ned long lisn)
>  	return 0;
>  }
> =20
> -#define XIVE_ESB_FLAG_STORE (1ull << (63 - 63))
> -
>  static long plpar_int_esb(unsigned long flags,
>  			  unsigned long lisn,
>  			  unsigned long offset,
> @@ -321,7 +314,7 @@ static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u6=
4 data, bool write)
>  	unsigned long read_data;
>  	long rc;
> =20
> -	rc =3D plpar_int_esb(write ? XIVE_ESB_FLAG_STORE : 0,
> +	rc =3D plpar_int_esb(write ? XIVE_SPAPR_ESB_STORE : 0,
>  			   lisn, offset, data, &read_data);
>  	if (rc)
>  		return -1;
> @@ -329,11 +322,6 @@ static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u=
64 data, bool write)
>  	return write ? 0 : read_data;
>  }
> =20
> -#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
> -#define XIVE_SRC_LSI           (1ull << (63 - 61))
> -#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
> -#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> -
>  static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data=
 *data)
>  {
>  	long rc;
> @@ -349,11 +337,11 @@ static int xive_spapr_populate_irq_data(u32 hw_irq,=
 struct xive_irq_data *data)
>  	if (rc)
>  		return  -EINVAL;
> =20
> -	if (flags & XIVE_SRC_H_INT_ESB)
> +	if (flags & XIVE_SPAPR_SRC_H_INT_ESB)
>  		data->flags  |=3D XIVE_IRQ_FLAG_H_INT_ESB;
> -	if (flags & XIVE_SRC_STORE_EOI)
> +	if (flags & XIVE_SPAPR_SRC_STORE_EOI)
>  		data->flags  |=3D XIVE_IRQ_FLAG_STORE_EOI;
> -	if (flags & XIVE_SRC_LSI)
> +	if (flags & XIVE_SPAPR_SRC_LSI)
>  		data->flags  |=3D XIVE_IRQ_FLAG_LSI;
>  	data->eoi_page  =3D eoi_page;
>  	data->esb_shift =3D esb_shift;
> @@ -374,7 +362,7 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, s=
truct xive_irq_data *data)
>  	data->hw_irq =3D hw_irq;
> =20
>  	/* Full function page supports trigger */
> -	if (flags & XIVE_SRC_TRIGGER) {
> +	if (flags & XIVE_SPAPR_SRC_TRIGGER) {
>  		data->trig_mmio =3D data->eoi_mmio;
>  		return 0;
>  	}
> @@ -391,8 +379,8 @@ static int xive_spapr_configure_irq(u32 hw_irq, u32 t=
arget, u8 prio, u32 sw_irq)
>  {
>  	long rc;
> =20
> -	rc =3D plpar_int_set_source_config(XIVE_SRC_SET_EISN, hw_irq, target,
> -					 prio, sw_irq);
> +	rc =3D plpar_int_set_source_config(XIVE_SPAPR_SRC_SET_EISN, hw_irq,
> +					 target, prio, sw_irq);
> =20
>  	return rc =3D=3D 0 ? 0 : -ENXIO;
>  }
> @@ -432,7 +420,7 @@ static int xive_spapr_configure_queue(u32 target, str=
uct xive_q *q, u8 prio,
>  	q->eoi_phys =3D esn_page;
> =20
>  	/* Default is to always notify */
> -	flags =3D XIVE_EQ_ALWAYS_NOTIFY;
> +	flags =3D XIVE_SPAPR_EQ_ALWAYS_NOTIFY;
> =20
>  	/* Configure and enable the queue in HW */
>  	rc =3D plpar_int_set_queue_config(flags, target, prio, qpage_phys, orde=
r);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw1a38ACgkQbDjKyiDZ
s5JbFQ//bNX/9AwaCdBGtNR1aU/uEhsb2+zvJ6guXXalkY+zuYmauUQJmpEbeZUk
oA1bFJtiB2/7p4P2VtVnSUEBzsydqXmP7pnmwzo4gMbU2lwPh1/pxZ6gTnVuWBu5
waqZ40sgOXJV5p9FGnULl5VuGLqAhO8vZjSXoJ3VP/suuQQ8Gq81maxDXPiWUCM4
jLNxjejGvVoIs3PQMUnLX8fGvt4NstZMrCFKhpotRTN4uI7YF61BIhBocR3sjnmL
9HF8Gri/sE83gbUOrRBIyw/LrzfswQOzEfBoolikmTXR+mGlTebwp476HMJxfvIj
RC+7epKJei1ffTEEpzVoElTh8fYMI4NOSNsDwYsQhfjk0CsrQtp57LOs8mCr5cRr
cRDXa4loXIBVMtxmH4iUqRnMJL5EDIBvVWIdXrs1DiewLwf9MLIGrsJ0HcruiCx2
bhLpWqk9IzYGcRKvDQoGTsTNU9J1pkazmmDVi9qITp+FAgg7GClTpzkgBj725G0r
i5zGQrMcQuuBp/WidUIIgBnxfSXB+JdIoBqGNj/6xF4i4QPZeWpZejoOOp8zTo0Y
la86SPQBQcWoqaON57zqOxApVHO2caCTMkELFGfFEoOuZKqS5YLkSNmUG954IyFh
Gm5ysYu2oOhb5ASjcfaHF70NathpNipvLugKj0N8vxwt8vlUiFY=
=3bDs
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
