Return-Path: <SRS0=/Qvz=43=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB0C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 05:21:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37252071B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 05:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UN1oPECF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37252071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48c3N6419VzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 16:21:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48c3Lj3340zDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 16:19:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.a=rsa-sha256 header.s=201602 header.b=UN1oPECF; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48c3Lg4hqCz9sRY; Tue, 10 Mar 2020 16:19:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583817595;
 bh=aN8E5yfBh5IMVaMorLM/md1F+PZSq6h0d7mwcFx6YlA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UN1oPECFxFl1Coib8FMtJIQ6eDaS6OZrjdNjEI/n2zR1zOSqPKfeEod2IXgjP9Sv3
 C1ekGz1IK0GmqlXHBVtN+QW76Ek2Y20KqItgrqe10exHzaUf9a2LqG2/3wfYn+RAHt
 rJqE75JCHj9gcyJakpswv7r0nD3R25Z2Z8e7OCLU=
Date: Tue, 10 Mar 2020 16:17:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/4] powerpc/xive: Use XIVE_BAD_IRQ instead of zero to
 catch non configured IPIs
Message-ID: <20200310051701.GO660117@umbus.fritz.box>
References: <20200306150143.5551-1-clg@kaod.org>
 <20200306150143.5551-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline
In-Reply-To: <20200306150143.5551-2-clg@kaod.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 04:01:40PM +0100, C=E9dric Le Goater wrote:
> When a CPU is brought up, an IPI number is allocated and recorded
> under the XIVE CPU structure. Invalid IPI numbers are tracked with
> interrupt number 0x0.
>=20
> On the PowerNV platform, the interrupt number space starts at 0x10 and
> this works fine. However, on the sPAPR platform, it is possible to
> allocate the interrupt number 0x0 and this raises an issue when CPU 0
> is unplugged. The XIVE spapr driver tracks allocated interrupt numbers
> in a bitmask and it is not correctly updated when interrupt number 0x0
> is freed. It stays allocated and it is then impossible to reallocate.
>=20
> Fix by using the XIVE_BAD_IRQ value instead of zero on both platforms.
>=20
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interr=
upt controller")
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/sysdev/xive/xive-internal.h |  7 +++++++
>  arch/powerpc/sysdev/xive/common.c        | 12 +++---------
>  arch/powerpc/sysdev/xive/native.c        |  4 ++--
>  arch/powerpc/sysdev/xive/spapr.c         |  4 ++--
>  4 files changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/xive-internal.h b/arch/powerpc/sysd=
ev/xive/xive-internal.h
> index 59cd366e7933..382980f4de2d 100644
> --- a/arch/powerpc/sysdev/xive/xive-internal.h
> +++ b/arch/powerpc/sysdev/xive/xive-internal.h
> @@ -5,6 +5,13 @@
>  #ifndef __XIVE_INTERNAL_H
>  #define __XIVE_INTERNAL_H
> =20
> +/*
> + * A "disabled" interrupt should never fire, to catch problems
> + * we set its logical number to this
> + */
> +#define XIVE_BAD_IRQ		0x7fffffff
> +#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
> +
>  /* Each CPU carry one of these with various per-CPU state */
>  struct xive_cpu {
>  #ifdef CONFIG_SMP
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index fa49193206b6..550baba98ec9 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -68,13 +68,6 @@ static u32 xive_ipi_irq;
>  /* Xive state for each CPU */
>  static DEFINE_PER_CPU(struct xive_cpu *, xive_cpu);
> =20
> -/*
> - * A "disabled" interrupt should never fire, to catch problems
> - * we set its logical number to this
> - */
> -#define XIVE_BAD_IRQ		0x7fffffff
> -#define XIVE_MAX_IRQ		(XIVE_BAD_IRQ - 1)
> -
>  /* An invalid CPU target */
>  #define XIVE_INVALID_TARGET	(-1)
> =20
> @@ -1153,7 +1146,7 @@ static int xive_setup_cpu_ipi(unsigned int cpu)
>  	xc =3D per_cpu(xive_cpu, cpu);
> =20
>  	/* Check if we are already setup */
> -	if (xc->hw_ipi !=3D 0)
> +	if (xc->hw_ipi !=3D XIVE_BAD_IRQ)
>  		return 0;
> =20
>  	/* Grab an IPI from the backend, this will populate xc->hw_ipi */
> @@ -1190,7 +1183,7 @@ static void xive_cleanup_cpu_ipi(unsigned int cpu, =
struct xive_cpu *xc)
>  	/* Disable the IPI and free the IRQ data */
> =20
>  	/* Already cleaned up ? */
> -	if (xc->hw_ipi =3D=3D 0)
> +	if (xc->hw_ipi =3D=3D XIVE_BAD_IRQ)
>  		return;
> =20
>  	/* Mask the IPI */
> @@ -1346,6 +1339,7 @@ static int xive_prepare_cpu(unsigned int cpu)
>  		if (np)
>  			xc->chip_id =3D of_get_ibm_chip_id(np);
>  		of_node_put(np);
> +		xc->hw_ipi =3D XIVE_BAD_IRQ;
> =20
>  		per_cpu(xive_cpu, cpu) =3D xc;
>  	}
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive=
/native.c
> index 0ff6b739052c..50e1a8e02497 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -312,7 +312,7 @@ static void xive_native_put_ipi(unsigned int cpu, str=
uct xive_cpu *xc)
>  	s64 rc;
> =20
>  	/* Free the IPI */
> -	if (!xc->hw_ipi)
> +	if (xc->hw_ipi =3D=3D XIVE_BAD_IRQ)
>  		return;
>  	for (;;) {
>  		rc =3D opal_xive_free_irq(xc->hw_ipi);
> @@ -320,7 +320,7 @@ static void xive_native_put_ipi(unsigned int cpu, str=
uct xive_cpu *xc)
>  			msleep(OPAL_BUSY_DELAY_MS);
>  			continue;
>  		}
> -		xc->hw_ipi =3D 0;
> +		xc->hw_ipi =3D XIVE_BAD_IRQ;
>  		break;
>  	}
>  }
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index 55dc61cb4867..3f15615712b5 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -560,11 +560,11 @@ static int xive_spapr_get_ipi(unsigned int cpu, str=
uct xive_cpu *xc)
> =20
>  static void xive_spapr_put_ipi(unsigned int cpu, struct xive_cpu *xc)
>  {
> -	if (!xc->hw_ipi)
> +	if (xc->hw_ipi =3D=3D XIVE_BAD_IRQ)
>  		return;
> =20
>  	xive_irq_bitmap_free(xc->hw_ipi);
> -	xc->hw_ipi =3D 0;
> +	xc->hw_ipi =3D XIVE_BAD_IRQ;
>  }
>  #endif /* CONFIG_SMP */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5nIscACgkQbDjKyiDZ
s5IfJg//TVb2COM4VBjygVw+JHH45auKanzXa4SQmbn+9pMhNqU7ngh85y6hfTh7
tfNsmMNqpXYpp+zc0+2qSgCWaLBKegtQXRGCvfdbQqXSscRkwiaC7ywSX24yQ0v/
YDP2SRbazQsB+Xjos0Mpj23xYqrlloGL6yvLtEPGXwNcu98bGODqAy61Ah5rQT7L
+Gn6raTwe6U2uaEpJz/qvTslBAZD12Ytqo5O3e46NCAzPAsxV65pOEoP0Feyev/i
gx2MqSuUTgSmhiMPH7utf9ZLy3aMFIQUiL58QbjmLtSRdibIJNdxTGpvcWB/n+nq
oIprQg4Zkr+PL8b80H/BQVZlm3RUlRtIqdAJxWY4rspu8gJgmI6QHvwPnoqfZWLk
6w/Fbr9rTWgUq4SrIWI5wCy2CRMRrbnlzw93G8HFGkvmkVM8IAk8TlwY/c6+ZA53
sp0w68ipPL2L99zZqLtvgxYX/v9rEqKkvc9hxPZ+FgnSV2nsHEXn6hqNk6jRoHFW
GYacbVXUryjlhd9xyasi6RGwITfMF57WIYdD4kR7VUe+bLwHJRV/jiDT7oF1xwz8
5ROulY4eVtuU+XxzeCG8e4ue1ItRUsv3ntWCaqEyg6Yp1zIr9KSZYFHcTJxXJcP5
QGUpjFhc6epwY9NjshEwotEzVNGd20vy/V7qqJlIDwY2Ht3mMko=
=nzVK
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--
