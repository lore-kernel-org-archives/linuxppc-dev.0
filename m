Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53227DDE22
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 07:09:22 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080201195040.GA8950@farnsworth.org>
	(sfid-20080201_205105_125569_63C0AC54)
References: <20080201195040.GA8950@farnsworth.org>
	(sfid-20080201_205105_125569_63C0AC54)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+ssxUH7rk1R4pMSOdRmE"
Date: Fri, 01 Feb 2008 21:09:00 +0100
Message-Id: <1201896540.4188.71.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+ssxUH7rk1R4pMSOdRmE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-02-01 at 12:50 -0700, Dale Farnsworth wrote:
> This adds the low level irq tracing hooks for 32-bit powerpc.
> This patch applies on top of Benjamin Herrenschmidt's patch that
> provides similar support for 64-bit powerpc.  See
> <http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044361.html>

Cool. Except that Ben's patch doesn't work for me on my quad G5 and I
still haven't had time to figure out why... We should try to get this up
for .26 now that we obviously missed .25. Anybody else have a quad G5 to
test on?

I can test this patch on my powerbook too.

johannes

--=-+ssxUH7rk1R4pMSOdRmE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR6N8WqVg1VMiehFYAQJv6BAAxIFwfEEB9aBxn4gibhaxeAfszrQmbHWU
E7PU1JfRqlT/nWgkxnXbd8lSnOOssrHPVwxlybf49exz5Bfql7fIpmN+lm3uTKtR
y6C5CALIM6ZKx5D3aVIEH5BAh4ljBdFjfY+4m7kb8Kzg9Mwlvax2Q308PJu8N/cs
46Q0LaCapOkuOpV182RjIVaBlrfnUdPSydj97+N7H302ZMJKVpTUUr8J4VrfUoZJ
GkodJku4ZWLmfXeoJlSeK4IKmHL5gg4lrGGbjlNXw7FiWv8zL/AXmcMWfo6DvUqj
INsLrWJbEJxWS1AOjL/loCoPhY5JmmjbqAoTKkY6EoCmOrvuVULc6PPWdswINvlp
L3MS8mMCih7JRehofPn/v2700LtzT83P1/i0/OyMYkUO3V13l4ybJyLxjLYqLewN
kE76pg4SqXHK1sZ4SxyDKzOC3DG+pzetnCe1X6DHPWujwvJLQTYyPj+5doqVxpFH
EMyxbtckpt/rRtNAKNNCKW5ih7P7/9+4jtgP5xpGcivK61PZvH+K2r3AunG481Zk
/N82ePNAxIW462Wzo2QVXvh6m6e06z2Cyqfdh2UKELfYYKQM1CZK+pnSw/Zn+17Y
OXdYhj4GsdzzGYEGiRHbJaeI0U+csHlqukd71htVU1x5DEdgNkSNZcYpQfrziT1A
q7VLLRIQksI=
=vTor
-----END PGP SIGNATURE-----

--=-+ssxUH7rk1R4pMSOdRmE--
