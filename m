Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58D95DDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 03:32:20 +1100 (EST)
Subject: Re: [RFC] PMU: replace information ioctls and schedule for removal
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1194814546.6510.20.camel@pasglop>
References: <1194523351.6294.11.camel@johannes.berg>
	<1194814546.6510.20.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-o39N7FPBn/qhqxr/8jA2"
Date: Mon, 12 Nov 2007 17:33:38 +0100
Message-Id: <1194885218.5229.47.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-o39N7FPBn/qhqxr/8jA2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2007-11-12 at 07:55 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-11-08 at 13:02 +0100, Johannes Berg wrote:
> > This patch adds sysfs attributes to the PMU to allow getting
> > the information on the PMU type and whether adb is present from
> > there instead of via the ioctl. The ioctl is made optional and
> > scheduled for removal.
>=20
> Acked-by:  Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> While there, maybe also expose the PMU version ?

Does anybody need that? I'm not against adding it but we never showed it
and I haven't seen anyone ask for it.

johannes

--=-o39N7FPBn/qhqxr/8jA2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARziAYaVg1VMiehFYAQI7ig/+LaG7h73c8tFS6svCNEGMbvdlJ8Xdf8Hh
mrglM9ogzrA+XDOpUFZun9iLbNNlM/aBb1KFMShn2meUYckwWgUANHdtdjDqEdFS
HkZbyj/S0Y8/rx8yAaCuBb98SzUgYI6ikpGEovFmoPa17kdG5p/2SE62I56mZ42i
9DEl8z+pqEa1YvZhbaG9cRTJaUCG8LKN4Wp17ojIiiZcJ4Tkmy9eNUFbdkdEeNnT
H5R55OXj4fipA5y8/HFMwkTFi7dPFcZa/23ctQc0KTmdvfbuC5f1c7q1hYJ/9bub
p3ADTnq+B5RPp5qDkgbUm/tzScF92VOdUI98Z7lys5puJraS6JhhxMLdVpK0CgVi
gxvJwv4Z3Cv6+w1X9/S4NIi8IdNXziZRi8vFVaPkukqyaeMg/OsWCrDmC8rhhQzc
NlF5+bKUC6wclEqr8iAZIRLLYzq+9RfjH0ArtUFN/TVapaCtmhxJ0bKPAHcsgt7p
4X04317BzqcByeF8/qoHRERSTu6f42jC14lnXn9SigduQCFw722mYAq/Oroze1+i
MmJqkw5ekQuNsteadRf5W0PlZa48oEF7wOIL04DEPYjvtE6E05Ss0RRE8ilV9o9Q
/pJIlYtEeEjZKXtC8JGzKJ1ye/DEBdXdUoTOOe9ctvk0PYeSoeBbagg8Y9i12QOQ
vQ3KHfqRV3s=
=y5MO
-----END PGP SIGNATURE-----

--=-o39N7FPBn/qhqxr/8jA2--
