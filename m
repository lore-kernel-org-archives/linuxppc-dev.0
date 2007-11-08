Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A470DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:38:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: fix powersave-nap sysctl registration
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1194462703.5996.0.camel@johannes.berg>
References: <1194462703.5996.0.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fNS2c6NjjopT3vI31yH/"
Date: Thu, 08 Nov 2007 15:39:44 +0100
Message-Id: <1194532784.6294.36.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fNS2c6NjjopT3vI31yH/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2007-11-07 at 20:11 +0100, Johannes Berg wrote:
> The sysctl check code complains about a writable directory,
> fix it.

Sorry, I missed that patch that fixed it already, please ignore.

johannes

--=-fNS2c6NjjopT3vI31yH/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzMfrqVg1VMiehFYAQKW5g//XxZsZlZY556pPcm3tTEeuAQMuRqlLuDj
E+scgymiMfNPkB1kxuv8dJPncdMH/KpIA5a9hyz5WOnkAkvkrin98qsMqY5gjQ3w
/ppqVP0kFC5RyAowHA+wuJpTI70Flkt4JWtcEhrZmY5AJ+KzmNW88rrpiYP+QiwO
Xernqg9MiaYZULs+5k8iBFLHFiyaACg3Q0ozOV1r+GGBrKT5/tA0xFcyG9OLvKsS
z+ccz83JUktQd3F8f9qUJivc0SK101ig7L1Yiko+mx8UARj0GjolJmhGTnn9Yr4M
dKtWQcm3ziqB+BIkjrn4T9wYWuPiQREDCf3J4dVP7I8/k2eArOzy+ArXGM6YTr3z
CUoXpQJS5/yrFnIlUEpP2y/woLBzFSXmHt8SYC9py+TdJ21EOMSWIVSuOkvdmtqZ
5hR/IMqSdOsIvMMgO2diIDSxvgpOgrphoysVRHDx+XTxLT5s6gqiVBGsOBu7/naX
qKMUiFUqoWUI7nJzEYAyiWOHSLWb8i2SENZUSBCj1o4Wyk7kNi7udUgTFEGzLVJR
PwMcEegr8uRsycqqt+8wTfiLchWlrHiDcPi/no0N+QkWHEPIfT07Bc7DdKRvH2sA
b1tG7/Xml6V5AJpZnLECQW1JeYCNJ9UNf0Cs1jCzdcniIZ9KF7nj/2BNOygu3qO/
NiZWxgVUlO0=
=ByCH
-----END PGP SIGNATURE-----

--=-fNS2c6NjjopT3vI31yH/--
