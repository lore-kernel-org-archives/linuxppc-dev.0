Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74FC067B56
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:49:15 +1000 (EST)
Subject: Re: snd-aoa: g5 tas codec problems
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152258426.9862.44.camel@localhost.localdomain>
References: <1152258426.9862.44.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UomaFieYQfqyDy49U9KL"
Date: Fri, 07 Jul 2006 10:49:08 +0200
Message-Id: <1152262148.15068.30.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UomaFieYQfqyDy49U9KL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> Also, we should try
> (if not already the case) to cache our clock/i2s state so that
> subsequent prepare() don't try to change things that are already ok.=20

I do that, the function reads the dws and sfr registers and exits early
if they match.

johannes

--=-UomaFieYQfqyDy49U9KL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4gAqVg1VMiehFYAQLeKQ/9G3nI8+chYsXcB/yeZZtFkpk6+9LtQumc
IoiHKV0EFSRDb0e0ebWiK7YtJpSnp1LWnDZGLvx+RcfPLAK+lozFQkGKGT619413
Vk4dkHUKEnNwTLQDlgOD+vZMp9ScnIfrRKnfd9HacBkZyD96z+N7gL52QUaYXKfL
MzKqnDpMjbMN/qQbGsDQhPeuMMhtOXiI4NOwekfuYPRrzzXDhRaBHsDWkoZVmS6/
qzXGADl9dNB2PLmjCf5WrOtt4Qb3roG8A/XgS61J90uZwOJiTAjNpEiwwSmP2hqn
ohqTFmqQ6AtFE8WkI1WXUS8YQsHAlaB3oBWzp6q7cY+kzg6/yiC812M9VMsNvabv
wKbzRyjeszZP3xO0HSQ8ueU+yPMJn3UXTB2oBHVcMe4ku04KOU60JO3esQQOmH9E
tCGW4/Qb2Mqlc3SyFW4B9ojL95ozfaHez3Bua0/BKNHOsAHxE7ijLULqxoW49vZ5
kiKEDDPdUddcDU0+oNfRn46g7cjiBRPtwyOXg8xrMtpvuLP8M0VjS2AgNrPnhzg4
3jlB4oYWa/w8aMYGFGAdBy8ZQ8c64Ptzg5WpQiVtXNMIwwbgH/l3E1cSQPLFzIRQ
iaSo8SCZ4dQwzR3sBrmSe8cAxOFeSw2kmzq3Dspq6zuU+DfUeXlHMN3QvdtXlZ0u
bOfm6UyE2kw=
=AfNX
-----END PGP SIGNATURE-----

--=-UomaFieYQfqyDy49U9KL--
