Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EE7767B89
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 18:35:36 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17551.16363.218140.484114@cargo.ozlabs.ibm.com>
References: <1150194348.9208.33.camel@johannes>
	<17551.16363.218140.484114@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PdSby7GCKjWRknnW37qx"
Date: Wed, 14 Jun 2006 10:35:19 +0200
Message-Id: <1150274119.13958.8.camel@johannes>
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


--=-PdSby7GCKjWRknnW37qx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 08:44 +1000, Paul Mackerras wrote:

> The elf_read_implies_exec() macro in include/asm-powerpc/elf.h
> achieves the same effect, I believe.

Even for mprotect()? It doesn't look like it does.

johannes

--=-PdSby7GCKjWRknnW37qx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI/KRaVg1VMiehFYAQLjdw/5AarQgovuBRtX0ETSjg9IR0vk8syhjfui
X9gbMA/rbUf0z+BNRVupXeCseSZPpw+6HBSslUeO6ajonsn6q06p/dezn0qBFV7N
a5zz5iun/aj0kYkTpo/RBnTJ1XiLVQJTMr0CSa/91nQpVy1IHfF5FkO7Yz6aTiOc
rPVJyOqscmUthJsWgSE7St+8IE/FpChLs7JJmCvcK8nYrbbAV9C11mxfSmiBKBbD
8TUQdQ30jVaqVFysUY+z+lne6pmHz5J2jRuyQ9E4z/Aeq7bzJiy4tEqX/Xh4Aud1
6VYF+RztWh70BLsL+qIPFiGvqLAJK7HHbvXGkVDDM59Xt0xN7UEnDgPFvcipuCjT
14tktyC/kBVPCJrbVIBnT7+mv1ou4Cuyt0jXG6U2FAuACthhMydkFSA1v14kasoe
e2i9DD7YBjoYa32UKOeyg/RTGCb66TQnyYc+Axgq1+SC4R5+c+uTfvj1kya3iOvV
+ISd4J+1p2TFEyZ4LcZo+kZAP47nRw7z7lQtq4QAyO9pu0iYSzpS/q+3Tpfy0uKv
CnoPoJchTfUWr/xnhoBHXNKTQjaLJ5Ghz38y4BDyTWYkpH7d4WL43KccRgMuCgrv
mV6ntyjxrOUo/M7G1W03HW7ueLBSsnp9pQkQmgOh8I3iWY2wheekF7/5q027lr+m
jpO0r7T2ZvQ=
=GnGl
-----END PGP SIGNATURE-----

--=-PdSby7GCKjWRknnW37qx--
