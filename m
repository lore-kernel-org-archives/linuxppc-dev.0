Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A6070DDF27
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:24:53 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Thu, 27 Mar 2008 10:24:45 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<b06db7bb4932d14f8af9547abdfc9d0d@kernel.crashing.org>
	<47EA6E88.5050109@ru.mvista.com>
In-Reply-To: <47EA6E88.5050109@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1916913.M1ef4UuZnQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803271024.51591.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1916913.M1ef4UuZnQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 26 March 2008 16:40, Sergei Shtylyov wrote:
> Segher Boessenkool wrote:
>=20
> >> - Using another device node with a compatible value set to=20
> >> "linear-ram" (or
> >> something similar). This would support both volatile and non-volatile
> >> devices, and a property could be added to specify if the device is=20
> >> volatile
> >> or not.
>=20
> > "memory-mapped-memory" perhaps :-)
>=20
> > Or, just "memory".  Although that one might play havoc with some
>=20
>     I'd suggest "ram" and "rom" then. Luckily the device trees don't cont=
ain=20
> binding for the real RAM chips yet. :-)

And when it will we'll be in trouble.

Here are a few names. I like physmap-r[ao]m better. Does anyone have anothe=
r=20
suggestion ? I'd like to send a revised patch.

linear-r[ao]m
linear-mapped-r[ao]m
mapped-r[ao]m
memory-mapped-r[ao]m
physmap-r[ao]m

> > not-quite-correct main memory probing code.
>=20
>     You mean the there's parsers that search the "compatible" prop for=20
> "memory" as well as "device_type" prop?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1916913.M1ef4UuZnQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH62fj8y9gWxC9vpcRAkhHAJoD9TNb44LA0qQhb6GhAFFziLuD5ACfYcbs
GQ3LMMw+KAbzUCZmxEdZgKw=
=idjv
-----END PGP SIGNATURE-----

--nextPart1916913.M1ef4UuZnQ--
