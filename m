Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821DBC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:58:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B3206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 04:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iRIybkYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZH2w0d3PzDqdd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 15:58:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZGzK3XlxzDqcg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 15:55:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="iRIybkYH"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ZGzK069gz9sCX; Wed,  9 Jan 2019 15:55:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1547009741;
 bh=2b/UgLKJaKcl8S/6GvD9UBJ+c0Vvols3qFo4/5Sqoqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iRIybkYH9aVJoXKwSLE2nkUNUKKFfnV5W8wlKHLr8BuQTl1HKAf4DsXnss0sQD4gj
 ImVJk6NQBJQqUM9Xbm9STdvMONFTHcqUxFShghAjZaZkVn4uKzPN8WXl1xdMNb4znR
 WD84xOVRzVongOaRjouwhPOQUSB/ngXlApiMQnh0=
Date: Wed, 9 Jan 2019 15:27:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 03/19] KVM: PPC: Book3S HV: check the IRQ controller type
Message-ID: <20190109042717.GD6682@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-4-clg@kaod.org>
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


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:15PM +0100, C=E9dric Le Goater wrote:
> We will have different KVM devices for interrupts, one for the
> XICS-over-XIVE mode and one for the XIVE native exploitation
> mode. Let's add some checks to make sure we are not mixing the
> interfaces in KVM.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_xive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index f78d002f0fe0..8a4fa45f07f8 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -819,6 +819,9 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> =20
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return -EPERM;
> +
>  	if (!xc)
>  		return 0;
> =20
> @@ -835,6 +838,9 @@ int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 ic=
pval)
>  	u8 cppr, mfrr;
>  	u32 xisr;
> =20
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return -EPERM;
> +
>  	if (!xc || !xive)
>  		return -ENOENT;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw1eCUACgkQbDjKyiDZ
s5IZWw//bTObuxMPb1akq3IURR/qXNVRLf1fJPA9YzltAybyrTTIxN2W9iJTOOCc
s+sYF4IhNaftoc3Pk5nB0W285GO25GfoQ046KW1G2zSpEs+mbc8liWH+NsoKLO+T
fkEuGCG6roS5rzlfeqNPwBwrGmYv6Wxu30okEq8w6YL1kQOqnDKTHBNVDeXomZA7
LajC67onw1+HdMklW0DvddxUa5P0LEEzSS6bQF0b53VwkLBgDcYTO51jq27fiVac
tb/reHFySePW1kcnhgOyHB8TMSLimybdqRqTUd3UubY3pjMuo92mMXbrINvjzfCa
maXDw/+PL0PHet/s6BtjoHzlwUIOcdkhr10y0qYQF/cDyCuh/CxgJ7MD4qh3NXZ4
KgJAY8iqQphvIkevSg69Pk7A8GMt4Tw+LqpcHv1gxW2LwKnrYWqQDsG51YdMf7yq
+OZw5nlcIkmM7BP6uC03jDA2JQrOi5FhZcptqnC5pRFx+kOtby/fWgB0hY61F5OQ
OH0Jk6AAgACH/doQgkneU777kmdlxWIpI6nn2Cw8nC0uz/P3XLyAANVBcaDWFKzy
b15GycbwFtcOdgmF4FtMkLOlAf48yk0NSYW7cUPHeaQFEVbFFmcbkClfzOknFIWx
Kg/U5CKLgEnZmj93XgwOAJtedZzviAv2uXmGuIKqNXIyCCdX+1A=
=Jb9o
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
