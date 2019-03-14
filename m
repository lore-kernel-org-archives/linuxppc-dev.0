Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E7CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:09:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B151206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hyLnCi/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B151206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KYbP2lXQzDqMp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:09:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KYQY19F6zDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 14:01:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="hyLnCi/+"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44KYQX47JPz9s7h; Thu, 14 Mar 2019 14:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552532516;
 bh=AmA7h0PF2maHIB2nMzJ2iMkdGPyEuQBSK3lTmGtm6xc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hyLnCi/+LhN5MIgdgD0FSb0n6eNc3vhMgbkBxaf/K6YlXj5feeqK+1ZWNp4md4Z0M
 aKz2+DCsfUCags0X7gw1jx2KY6Y2D9XwFjZ7++rkUWLpgOfdYyFUE6PTvbM4ZbYUlA
 tsUcIcMSpvM+DUFqEYDqgTkJzF5xesdTUhhZ4aHA=
Date: Thu, 14 Mar 2019 13:29:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Message-ID: <20190314022921.GK8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org>
 <20190225043551.GA20501@blackberry>
 <a736c1b9-6406-2afa-d126-d0073fcd096e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Content-Disposition: inline
In-Reply-To: <a736c1b9-6406-2afa-d126-d0073fcd096e@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2019 at 09:34:53AM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 5:35 AM, Paul Mackerras wrote:
> > On Fri, Feb 22, 2019 at 12:28:27PM +0100, C=E9dric Le Goater wrote:
> >> The user interface exposes a new capability to let QEMU connect the
> >> vCPU to the XIVE KVM device if required. The capability is only
> >> advertised on a PowerNV Hypervisor as support for nested guests
> >> (pseries KVM Hypervisor) is not yet available.
> >=20
> > If a bisection happened to land on this commit, we would have KVM
> > saying it had the ability to support guests using XIVE natively, but
> > it wouldn't actually work since we don't have all the code that is in
> > the following patches.
>=20
> OK. I didn't think migration was a must-have for bisection. I will move
> the enablement at end.

Any temporary feature regression potentially breaks bisection, because
you don't know what we'll want to bisect for.  Obviously we're never
going to get that perfectly right, but that doesn't mean we shouldn't
try when we do see the problem in advance.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyJvIEACgkQbDjKyiDZ
s5K/fA/9HVXwiMV7ZGg/YTkKCWDnhXC9X7k/RXhZS01U8jk0iSYIGRfExw6cGcwU
ZxZt2ENgHXl8dtUCcBf6WGBtX+jsBLCmG3Bb8wBr69UotKNdyqI4ob1AKfxw+/uk
cU2fuLl74Jch163M/82O2+jcQJu+HW8ou7med38L34fBi1Z9ezkVFlWkvGHWS0MN
Ly/DqRf2TZjJhLDXqsQEf+Zl2CV4450ALa4+2TV2Qi/QuOkODSC3wnU525Ujao50
Xglc7fAQJ/wCgc6cGQCC0A8EVkfTqBovPLuBbvw2ZGSDLuVFZez6lYV1e1Q+h/q+
keWw/dN+f5ZJBstWWUewL/ZSXYrd+XKwBI8Qz/oXZ3eU3mTPh9bcKre1cjSTzp8r
bXkpKo4pBxy446wuFekqnYXm4suBlGamdcPgKxtzLH9wlDbWBPiFL2aFCf6/Br9e
30FNjpOirmID8sCIQcaV+EkA5LlVZjMHYU9Ijv3DISVsGyUFZ7wxc3ruQNj4agFH
2bYnWsM1LXByuh7m6uu6/yOPLIRZapMBecAES2tBZ9a/mjVDOFbcT2cN/B5iTAJj
+Nn+6WhbuWI3th0OQffL81LwSMawPp9EyG+aC60swlCdXzr8PuIXnrp29zVRJDs1
Dohadfa3i0lC7bn/PHoXsjsedJ7cp/UvB5ecYijsX5HX6DJyOyY=
=pWKO
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
