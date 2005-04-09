Return-Path: <kreutzm@itp.uni-hannover.de>
Received: from mrelay3.uni-hannover.de (mrelay3.uni-hannover.de [130.75.2.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C0FF67B49
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 00:06:29 +1000 (EST)
Date: Sat, 9 Apr 2005 15:48:14 +0200
From: Helge Kreutzmann <kreutzm@itp.uni-hannover.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050409134814.GB17777@itp.uni-hannover.de>
References: <1113006674.9568.414.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
In-Reply-To: <1113006674.9568.414.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
On Sat, Apr 09, 2005 at 10:31:14AM +1000, Benjamin Herrenschmidt wrote:
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:

An ibook from spring 2004 (PowerBook6,5)

> echo `cat /proc/device-tree/model`

thirtyto:~# echo `cat /proc/device-tree/model`
PowerBook6,5

> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && h=
exdump -n4 $i; done
>=20
> If the later returns nothing, it's fine, just tell me.

Yep, returns nothing.

Hope this helps.

       Helge
--=20
Dr. Helge Kreutzmann, Dipl.-Phys.           Helge.Kreutzmann@itp.uni-hannov=
er.de
                       gpg signed mail preferred=20
    64bit GNU powered                  http://www.itp.uni-hannover.de/~kreu=
tzm
       Help keep free software "libre": http://www.freepatents.org/

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCV90eRsxcY/MYpWoRAlKfAKChidBRm9mysDVgqXnT9KDEVJxyaACgvAiE
14+3B71/Zx13Da7gXDZg+YQ=
=teED
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
