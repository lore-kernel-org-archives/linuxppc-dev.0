Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8724F67C41
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 19:27:32 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149897784.12687.87.camel@localhost.localdomain>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
	<1149897784.12687.87.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yWep4qKOpMLcutffZjkq"
Date: Sat, 10 Jun 2006 11:27:18 +0200
Message-Id: <1149931638.3864.34.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yWep4qKOpMLcutffZjkq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-10 at 10:03 +1000, Benjamin Herrenschmidt wrote:

> > I don't think your patch is right, it seems to me that now
> > pmf_unregister_irq_client races against pmf_do_irq: what happens when a=
n
> > interrupt comes in right in the middle of the list_del()?
>=20
> Yeah, possibly... too late for 2.6.17 tho.

That's ok, we don't have any in-kernel users anyway. Alas the alsa
people will be dissatisfied because they like to ship new drivers for
old kernels or something. Oh well, I don't care.

johannes

--=-yWep4qKOpMLcutffZjkq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIqQdKVg1VMiehFYAQLIEA/+NpbNteiSAiLFoH4Ek1lFccBve5YfsEfi
epB+s/ei9R5zyailk3+4gZoBGzL3GVxm+UH3dKhN8xHE8rOG5t9/Fo8kjaaHC/OY
8XEJzdCucyIvnYmIi57Rm5Ygo75dJDfggfmb/XGKrJwJzWsf13RwEVUMbSGmP9Fy
gDGROxrI4GBPQY7UnjdGJB2ixd3CaCBeICGraPV7SivHhCr1jm/sRSFK0f7PkXhu
o6qrmBZIc/FytSxAWpFX6rwWGWxIQ75iNEiKQcNdqfoMDSDtHSYCFT/F/0tVt0vt
HTB99i7FueIzacBWew+hsLrK+VHQjsdIJ9VmJ0snkY+1f2IoPnS2sV/7PssYnU8h
Czpwb4IBlCjHJkxfhjHbZbE0cEOCAzgz0dHjln/sIo7JEQjEFj4pYkoMkSwXhbVh
ePFT2J3N0+NfBFuHUsjnh6aALOXjZzrTAA2dwCM8T7dfiRuCeMK8AsPAc4GfKVlG
diHCDQxrcBkxtaFZ0maDCFsegRf1vbmG7zmzr4mIWxXkp8e/Z4LsB89+J2DiaPaB
IxSAHtly8J4zhn/347Fb8ga/VzEQZL0atU1vmy1mg3mnmT8gsfWnInV4uqWXYmb+
92Y5w6iKMj/SK1hq6gFpiZJK9Gv/M7xvSlqgxDw4lox+PiyGtimbUb/iBHfVeV0y
8pgV34BSP0c=
=nzwJ
-----END PGP SIGNATURE-----

--=-yWep4qKOpMLcutffZjkq--
