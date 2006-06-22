Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A21367A3D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 21:14:37 +1000 (EST)
Subject: Re: [linux-pm] windfarm got signal
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <200606221303.19860.rjw@sisk.pl>
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
	<200606221303.19860.rjw@sisk.pl>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WiGq600AMU9fbjUmlO28"
Date: Thu, 22 Jun 2006 13:13:56 +0200
Message-Id: <1150974836.16258.29.camel@johannes>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WiGq600AMU9fbjUmlO28
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-22 at 13:03 +0200, Rafael J. Wysocki wrote:
> > I think it's the way the freezer works ... it sends a pseudo signal to
> > all kernel threads who are then supposed to do something like test for
> > PF_FREEZE or something like that.
>=20
> Yes.  More precisely, they are supposed to use try_to_freeze().
>=20
> Please see Documentation/power/kernel_threads.txt.

Thanks, I'll look and submit a patch. It does try_to_freeze() but also
checks for pending signals.

johannes

--=-WiGq600AMU9fbjUmlO28
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJp7caVg1VMiehFYAQIL2w//VAlo04DmI9YlfhhBMQshJ7ZA209rlyNo
aU/7wWHvsYdlRcoRARNipuwWMkWvclEnII7PSASgkWD8/asPJ0iX0syOlhMTUyNG
jgv8d5zhKHYrbv9mpB3kHQfVtSc8g+hvGrLHrS/f350G71VrEAbpVEjTtGTX4OAk
oiXL+9HEud4Y04kVoLLT1h3/04HmvUvL5Y/017FtylhP2F81hEzyKeOtjQTlMCRl
1zT821b/nKNUujaucc8nhKzb+VkOhuq6KRjx7supK+Tthxhue113aF0r2+qY2MI+
SQRxTqLU5+NxwV8DRzPabMSyXzi0USuzihdJWRUFRitoQ6RfCRD/eDc5+Tvuis/p
d5x13Bxxx1TefBVPDr6qOJRlvb/2J+qXILY3bjL1+g7e1JvUjfSDhDeyl/4n1GOG
Lprip6g8QPZrCLTLOFeaeaEiPae0gX3OXsxsvFx5A5IfbJhpABBslGgpG2dk0m0n
4872hvIz4KIpyPjq7bjhRxE3pVNSjoab8SW9+AtpZt9PsFzUV0NHyc6QsPRLnlkr
aLxhLQPZmIFQSoqSIXOlmOPIqknDFOgvia9WU1VJKzXwbKnmiUk7KZDj/lz3yrod
TQ/OlL7vjtIb5a84cKPsrv4Jnj23/W86jeAPljMqVilNIODg17p3mP3H9xTjamiM
3NGl4VQVPhU=
=9sPo
-----END PGP SIGNATURE-----

--=-WiGq600AMU9fbjUmlO28--
