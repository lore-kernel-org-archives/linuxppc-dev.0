Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9391DDF4F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:22:17 +1000 (EST)
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <1193217742.5715.6.camel@johannes.berg>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
	<20071024091446.GL14671@kernel.dk>
	<1193217742.5715.6.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oP8ABcM0RTOouauj/5/r"
Date: Wed, 24 Oct 2007 11:23:36 +0200
Message-Id: <1193217816.5715.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oP8ABcM0RTOouauj/5/r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 11:22 +0200, Johannes Berg wrote:

> No, it came out after I pulled, I was on v2.6.23-6815-g0895e91. I'll
> give it a try, but I don't think I can confirm it works before tomorrow.
> I see the build failure got fixed with commit
> 5edadbd0ae35d2daabaf6b44f2c58d67d4021ed2 too.

Wait, now I lost track. This patch is identical to that commit 5edad...,
what I was thinking of was the oops I got.

johannes

--=-oP8ABcM0RTOouauj/5/r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8PF6Vg1VMiehFYAQJPLQ/9H/6BnhhxTUJeos0/uajME07kqVQRh/Z8
4zUIIwTEVxnPLj38ua5ISpSGR9ezmz7/XToEqJoQQQy5zv2PfRF8jhzznAaCa6N1
NgmrPsBTpa+e2lDfZigfVoovXAQ5a+O5bmXY4lFXM6bgM6YxGvKCv01S5S0AZ9fe
cmL+98rEXmpsxY4QF7ppWH/4ymXS/yEXEMLeWv28F2iaft68yMU9iFp7aaLvTuo1
MhYE5hTj/FipBpQ4fgths5Z4UvwrrM5pEqLY4H84n/GWbLIw4pXjeqFxC7nsE//q
DUSmFRlaLp6blluOKIzSh1BtmUZF4E4s/zeIlSF14dPf6CFgHwjMXkV2BmYJZ5Q6
MypXMXR/d8ddTat37hXq2Hv3XPkmIqETSmtZrxpp9Nd8zuQOWrtRCO50pAE6+6+z
YFREuxRCM27rN2qoI9uapP1qUzi9i1vIRVYyWE0HSVVO7tZKApQbSssjpqs85CMU
hj+0/9l+B3g/A4NYB6Di5nM45qI0vQuib3yURFUo1Ds1YeRznrH5XS5aNUC4/EnV
1UH6eE5REN91kEOaFKSYieAM3zbdNPnmB82pNbwAcLe2CxJS4hEiYGXUgMqVPZ0G
y4EsTVdP/zZzlLtBNbvY46AH+AVTKGv11T11e52fVXlpdF+pkPcl4WaoOSJv/agG
i7TWXlPFwIo=
=MZ3s
-----END PGP SIGNATURE-----

--=-oP8ABcM0RTOouauj/5/r--
