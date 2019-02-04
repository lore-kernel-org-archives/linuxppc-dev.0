Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C2C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:19:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2FB2075D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="beIU46ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2FB2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHbb5VxpzDqHF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK22hyzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="beIU46ab"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSJ6Zq9z9sMp; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260768;
 bh=8WA82f97w+KJEvWK7swIwJzB3BEUqBVMaG2iXfjht1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=beIU46abkHxXCfwsEQy6DzI69tOt/QR+IgBZsKOPBcJ0d7PbG//C73+ga435GTV/p
 VUZe6dvGXtOKXOkOgQmj7XGzUlPZWL8c95E7l0AduqdLxf+Vosyewd9n1r2FW4KO8Y
 Z/CCfY/qjH0j5beSPU/vaKTOyHuIF0p0YOGVXKt4=
Date: Mon, 4 Feb 2019 16:15:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 12/19] KVM: PPC: Book3S HV: record guest queue page address
Message-ID: <20190204051548.GE1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-13-clg@kaod.org>
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


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:24PM +0100, C=E9dric Le Goater wrote:
> The guest physical address of the event queue will be part of the
> state to transfer in the migration. Cache its value when the queue is
> configured, it will save us an OPAL call.

That doesn't sound like a very compelling case - migration is already
a hundreds of milliseconds type operation, I wouldn't expect a few
extra OPAL calls to be an issue.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/xive.h       | 2 ++
>  arch/powerpc/kvm/book3s_xive_native.c | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index 7a7aa22d8258..e90c3c5d9533 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -74,6 +74,8 @@ struct xive_q {
>  	u32			esc_irq;
>  	atomic_t		count;
>  	atomic_t		pending_count;
> +	u64			guest_qpage;
> +	u32			guest_qsize;
>  };
> =20
>  /* Global enable flags for the XIVE support */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 35d806740c3a..4ca75aade069 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -708,6 +708,10 @@ static int kvmppc_h_int_set_queue_config(struct kvm_=
vcpu *vcpu,
>  	}
>  	qaddr =3D page_to_virt(page) + (qpage & ~PAGE_MASK);
> =20
> +	/* Backup queue page address and size for migration */
> +	q->guest_qpage =3D qpage;
> +	q->guest_qsize =3D qsize;
> +
>  	rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
>  					 (__be32 *) qaddr, qsize, true);
>  	if (rc) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXyoEACgkQbDjKyiDZ
s5KikA//YK3VIaauh55+vCxTD6veg+pvjhIR70gtNpSox8nKA8uYAe9edGvbqKy2
zrD+YR5zvhDl3LiQGN+CMPy57hmxriWKydb9nKnNjR1lyEdoqwP9QOV1meSORh+T
MulbEgLyU39zFdeXEO9tOEDVNxCyF+P6HfBzqQdWDs3jfMtyZqVbMrbk2gMWuH6W
gpfNLiECna3t1AEPKf4kntVAAC3FsEDuqrCzfAJhxUjBT0nwvGNGnQrdVQx2Zyfm
u+kQWeIAzOs+7tlkvdwgaHCW9zvTBaE/gdW9KefvCg7EpkQTVE14eaVd5hEWbZWS
uV62XwhpS3Uqz5a4Trqwv/G+jQTcOWnDePefVOntUMkaW9W/06vYWtiIX41eeEy2
8GUCSI7W91TtGPmgQtYeoKFr/qp8iffSAku9k2WteX32lTJLOWhSRX88RtwS/UAl
aUXYi2VsuHp09s5qXxCCXdO5Ark7MAaHmzY9HhR2DOo+KCaA9Y22WlhbXDaXHt4u
EWGE5cet3/JvDPk5RlRBaQlaxbeCH7YGONI/YtxULl8bWO5mZuqhnv1Nc4Ytv89a
1sVjkUyaSpem4+lXz6CW67PBvStOvq8q3blPkHRqHNWZkeVJ0yb6b6cUn70t6OTw
CsgmKhDd6SPcwPegGrmO7Uq3OGcdsNRBLNr5hxoBvHTM3Nf5PV8=
=155r
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
