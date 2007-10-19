Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] NULL terminate the pci_device_ids in pasemi_edac
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071019064725.GA1806@lixom.net>
References: <20071019150722.8d48eb1d.sfr@canb.auug.org.au>
	<20071019064725.GA1806@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zHdkcW4d0KanMgsSc9Io"
Date: Fri, 19 Oct 2007 20:34:32 +1000
Message-Id: <1192790072.6345.3.camel@concordia>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zHdkcW4d0KanMgsSc9Io
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-10-19 at 01:47 -0500, Olof Johansson wrote:
> On Fri, Oct 19, 2007 at 03:07:22PM +1000, Stephen Rothwell wrote:
> > Fixes:
> > drivers/edac/pasemi_edac: struct pci_device_id is 32 bytes.  The last o=
f 1 is:
> > 0x00 0x00 0x19 0x59 0x00 0x00 0xa0 0x0a 0xff 0xff 0xff 0xff 0xff 0xff 0=
xff 0xff
> > 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0=
x00 0x00
> > FATAL: drivers/edac/pasemi_edac: struct pci_device_id is not terminated=
 with a NULL entry!
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> Acked-by: Olof Johansson <olof@lixom.net>
>=20
> Thanks for fixing this, Stephen. ID lists without termination can really
> cause weird problems at the most random times since it depends on how
> the kernel is built whether they do any (immediate) harm or not.

Kind of makes you wonder if some macro foo to automatically append the
NULL entry wouldn't be a good idea.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zHdkcW4d0KanMgsSc9Io
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGIg4dSjSd0sB4dIRAs/9AKCsovT7QtpQ6wC+Maizjww/YgvqzQCgyloR
4nNLHRoRBfL/G2/E8E3F6FE=
=D1Yi
-----END PGP SIGNATURE-----

--=-zHdkcW4d0KanMgsSc9Io--
