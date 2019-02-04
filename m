Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7605C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:20:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDFD2075D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EY6CV2eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDFD2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHdC6c0gzDqH5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:20:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSJ4fxfzDqGS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="EY6CV2eD"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSJ3358z9s6w; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260768;
 bh=zlj9NlTzIoKqLyKIDok+5COT5xY4aGzNHLZuCCKrG7k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EY6CV2eDZMsPz3wmOst84udSldQFqyaH4Y5+LjwtkesGxPX9kLbPKnqPl6PsXxeHO
 m4eSJZ/oFTtzwULR8LwJAVmOYadzxsyCAZRlmVYpTNuKRVyecYvGlYC0GErrJPFVF9
 seA5uoPaWC7xtvaM1n8j2koc8HveEh5mD5oQU+gI=
Date: Mon, 4 Feb 2019 15:49:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 08/19] KVM: PPC: Book3S HV: add a VC_BASE control to the
 XIVE native device
Message-ID: <20190204044933.GC1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-9-clg@kaod.org>
 <20190122051430.GE15124@blackberry>
 <8c45581e-466e-a390-e9cd-a06b5939d2af@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <8c45581e-466e-a390-e9cd-a06b5939d2af@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 05:56:26PM +0100, C=E9dric Le Goater wrote:
> On 1/22/19 6:14 AM, Paul Mackerras wrote:
> > On Mon, Jan 07, 2019 at 07:43:20PM +0100, C=E9dric Le Goater wrote:
> >> The ESB MMIO region controls the interrupt sources of the guest. QEMU
> >> will query an fd (GET_ESB_FD ioctl) and map this region at a specific
> >> address for the guest to use. The guest will obtain this information
> >> using the H_INT_GET_SOURCE_INFO hcall. To inform KVM of the address
> >> setting used by QEMU, add a VC_BASE control to the KVM XIVE device
> >=20
> > This needs a little more explanation.  I *think* the only way this
> > gets used is that it gets returned to the guest by the new
> > hypercalls.  If that is indeed the case it would be useful to mention
> > that in the patch description, because otherwise taking a value that
> > userspace provides and which looks like it is an address, and not
> > doing any validation on it, looks a bit scary.
>=20
> I think we have solved this problem in another email thread.=20
>=20
> The H_INT_GET_SOURCE_INFO hcall does not need to be implemented in KVM
> as all the source information should already be available in QEMU. In
> that case, there is no need to inform KVM of where the ESB pages are=20
> mapped in the guest address space. So we don't need that extra control
> on the KVM device. This is good news.

Ah, good to hear.  I thought this looked strange.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXxF0ACgkQbDjKyiDZ
s5JCZRAA03WzDXc4NHhQ38Q+zz1qA2QmDhJK4TB/QzJSUwnnw0CKwXpeVE84h57Z
CxS96Uct2BL0GFrNJ+h6SX868QwxH/54TRMtEdX6BEl21XcnDkqFbCqwpqNwoWRa
+jsEsEPYXWEr0/JA94RTPSsuprFfAUTe88+thpGmdoAffGK6lMlKuQukJENirY/W
YinqShutDg+YRF/90qrqUgNXGc56UDBN7KiWJL4nDhaWXs+VqYSUY/pkeyu8G8+D
xEXtKVomC3ORULxLKUbkWUSMHpCVuK4wkb6SYH7TC7qhEtE7iiluZc6QaMuaa/ls
Ccg7LfShxf5lTQE7AO/hZo/4TXSZRinLqp0Ms2bSQqsAK+GbXgDDAphgXEbEp1It
r0mucPLgAiohKKffyYeQ8YmS4zmoW2yiFFqOxwOHIhyfag1ijJuWtVXY9CVkkaA5
AcxphN3v9Hd3fY1m5rm/NU/5ZuTHqkcvgQ4V1cNEjWAIhO26G6ysrRJBQIU8fftL
cVOqL01yFqqtWzmAiGGbRGBbE8MSLj34dKT9f4R/v7Fikn7c6BiPqaZwbEnoqJij
0YH/SzRU0f5Y2xBqaiL/4w1Sr5serY2jX2VXRLDaSNgMEdbWkSVLAOixSHtlUA88
SaDU8q5pbyBSE8JrG7N2WKpUGWhp7UfIYq2k8mBPGm8JPoW1Ols=
=Gl8u
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
