Return-Path: <michael@ellerman.id.au>
Subject: Can't build drivers/infiniband/hw/ipath/ipath_keys.c on arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: support@pathscale.com
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oza28Gm1bg3PFnWaIU/z"
Date: Mon, 06 Nov 2006 18:33:18 +1100
Message-Id: <1162798399.8175.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	openib-general <openib-general@openib.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oza28Gm1bg3PFnWaIU/z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Just a heads-up, drivers/infiniband/hw/ipath/ipath_keys.c doesn't build
on powerpc because we have don't have bus_to_virt().

(Actually you can't select CONFIG_INFINIBAND_IPATH on mainline because
powerpc doesn't enable PCI_MSI, but we will real soon now, and when we
do this will start breaking people's all modconfig builds).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-oza28Gm1bg3PFnWaIU/z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFTuU+dSjSd0sB4dIRAup1AJ9ygbdD8DqorZHv23V/8bfR8QNp+ACdFMeX
XUFInlOQ9yEysTv2seK8fNs=
=7m6w
-----END PGP SIGNATURE-----

--=-oza28Gm1bg3PFnWaIU/z--
