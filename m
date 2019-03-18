Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBEC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1F420643
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ahf1oZKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1F420643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N69l3hSCzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 17:44:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N67f5cPgzDqJS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 17:42:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Ahf1oZKX"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N67d4hyVz9sBF; Mon, 18 Mar 2019 17:42:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552891373;
 bh=BbP2MHmDC/b9d7Ri0Yxo1eyXk/f4RC2IkM590qzWA7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ahf1oZKXxhT9UmDoVcXUcPEYFVx79+AG5FU0LxROm1L58XgjYnc5kJByBfco6YszZ
 URxYWeF+kbj2shdgGnV8kGvjTdIMncmjHaWzpT+vcqeFHo0OWjgQb72Rih66jVTxEi
 YY5zpmzSJ1vhzV0yK7XM5Ar25vsqkjqtOhxTzYzk=
Date: Mon, 18 Mar 2019 17:42:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 15/17] KVM: PPC: Book3S HV: XIVE: activate XIVE
 exploitation mode
Message-ID: <20190318064215.GM6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HL3CiL6n73+IAdG4"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-16-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--HL3CiL6n73+IAdG4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:07PM +0100, C=E9dric Le Goater wrote:
> Full support for the XIVE native exploitation mode is now available,
> advertise the capability KVM_CAP_PPC_IRQ_XIVE for guests running on
> PowerNV KVM Hypervisors only. Support for nested guests (pseries KVM
> Hypervisor) is not yet available. XIVE should also have been activated
> which is default setting on POWER9 systems running a recent Linux
> kernel.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/powerpc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index bb51faf29162..d70b19f8725b 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -573,10 +573,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  #ifdef CONFIG_KVM_XIVE
>  	case KVM_CAP_PPC_IRQ_XIVE:
>  		/*
> -		 * Return false until all the XIVE infrastructure is
> -		 * in place including support for migration.
> +		 * We need XIVE to be enabled on the platform (implies
> +		 * a POWER9 processor) and the PowerNV platform, as
> +		 * nested is not yet supported.
>  		 */
> -		r =3D 0;
> +		r =3D xive_enabled() && !!cpu_has_feature(CPU_FTR_HVMODE);

Nit: && is already a logical operation, so there should be no need for
the '!!' here.

>  		break;
>  #endif
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HL3CiL6n73+IAdG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPPcUACgkQbDjKyiDZ
s5JLWA/+LxwfSrc+t6qJWKYlK+kkfMfbLG6mmS+iEl5JnuaSnYgDMX2RSSKq1SMI
T4SgbCtp96X4Y95ui10lFHa/discjkWkLuAUfypn/2cX+LGQDpYl1TQOuoKpLGTY
fI8DXGn1khBxIo/I5IqI6zJY7k0ROH3m0RpVVq50X+oVtz/3LRRhT0b2i4naSPob
o6F/K3obYJOX0ojnlBF6eWIMlGH/Ke+7IRZLRpXjvXz02TI0IphdFDL6lcY24KSH
f4eMuLEyzxs/6da52allb0N79m/Kn1XrkCMaGXW/XIakJvcfIWWwFIAcbfR2UaYn
ungItkGB92ZQ8HY0s86ygkk7tYiuXFo/ymbqo6NQYMv3gbDusO8B9lWr3izqKkFm
kjY8/VBRJVE23MpXZlwatEIP/6E2BJ+g+WbQJ+72y5ZuLNuObPHkjfFbENBA4mNf
5RCN/i43/EyVcLHWmXQmG81N8imKWs/eLo2KR969IkygKaWJV1M/bwkvzQAwyC1E
C6B0tU2af6gvxOy0j7BXdvtkzFsBBOqQdDBjKQnQOCymf0te3OR9FP5mbtQEbTn7
Ojygz2gyfnEYC52Aihe2XRjqr5LN2zc3wDcLvOKCLywB9Xm7griTjxL+wSIbsrbm
fOcezy5NFn6ocvbuQmOI9ru6Ka2kak/lp5b++rhddE7BAOaJgU4=
=peFu
-----END PGP SIGNATURE-----

--HL3CiL6n73+IAdG4--
