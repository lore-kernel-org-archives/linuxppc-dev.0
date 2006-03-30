Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EE6E67A40
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 00:14:36 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143672819.32206.1.camel@localhost.localdomain>
References: <1143547826.13615.24.camel@localhost>
	<1143604878.3585.5.camel@localhost.localdomain>
	<1143637243.9481.17.camel@localhost>
	<1143672819.32206.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-a/Drl2KuZ3kTRTzvf5Ov"
Date: Thu, 30 Mar 2006 15:14:28 +0200
Message-Id: <1143724468.20571.21.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-a/Drl2KuZ3kTRTzvf5Ov
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 09:53 +1100, Benjamin Herrenschmidt wrote:

> On the laptop.
>=20
> Mar 29 11:11:51 localhost kernel: [  192.069735] i2sbus: found i2s
> controller
> Mar 29 11:11:51 localhost kernel: [  192.069752] soundbus: adding device
> failed sanity check!
> Mar 29 11:11:51 localhost kernel: [  192.069757] i2sbus: device
> registration error!

That is, umm, weird. But it shouldn't cause the module to crash either
way so I'll force it and look into it.

johannes

--=-a/Drl2KuZ3kTRTzvf5Ov
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCvZsaVg1VMiehFYAQKcXg//aqrzUTFGqPl0EwgUKlP+HxTbcIdKjFx6
ZEW9lDZcjBqYmUJ5yaVrWCpIFKAKtsQkx2ZXSLO/2f9WzRGl/+vUxYta6SdavREQ
GRoImhIejkKRRRhmRL9UsQ/wRMrlgr0tJ3OdI/hImlDzssZMi990qF2ctldYT7ZN
KltZ1uKqNwfgLCx/gloBug7N61pPGMXif4KqvfeI5fPKn8MIqVaRQHP8eTT45byQ
Ky+3+rceSRozGNez+WIZUB5P7wKxy2PcdMezct5Wu8BX7hxqJqFHDpPZ386U6vmv
NHqinAj1F0L1O2ciKkceVvOMUshHg7g1fSsLJkmT+BWA1VQ0oECZ/na9LPlA7uhf
qMbpUEtWTJoG6SOQfD1jYM+RoOrVS1uHVJl2v/N/IbvQBVWqXUdiY43enj4G+LIh
7DdiZN+4wAqhXy8GnMEd+dGEBizjeAl63b8p57fWzokOT6w8VJDZ1EPKuYjQ3OLR
WRLe+kK5oR+At99x+9wDdO4cYvDYhIKHpw4Ncs5F7y2q/y/3nODvTOjuENEXPEPQ
VdscfnN0buaa/X1dRtpHgqULVCtAjowK5pqvbWYylXMG5n8s9UmcU4J/eTAfTIYB
K03iB5au1C9Sa22+t4j2NI3MZhwkpOPCNOGGK1HGNEbCYVblYys65aTpbLo6bTUK
/K3QDW30vSg=
=JVD8
-----END PGP SIGNATURE-----

--=-a/Drl2KuZ3kTRTzvf5Ov--
