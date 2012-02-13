Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 14 Feb 2012 09:44:19 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH stable-2.6.27] powerpc: Add more Power7 specific
 definitions
Message-ID: <20120213224418.GA22646@thor.bakeyournoodle.com>
References: <8849.1329094322@neuling.org>
 <20120213063528.GU21225@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <20120213063528.GU21225@1wt.eu>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 stable@kernel.org, Eric B Munson <emunson@mgebm.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2012 at 07:35:28AM +0100, Willy Tarreau wrote:
> On Mon, Feb 13, 2012 at 11:52:02AM +1100, Michael Neuling wrote:
> > stable-2.6.27.60 added c24cb8e5 which uses PV_POWER7 but it's not
> > defined.  Following patch adds these definitions.
>=20
> Thank you for the report Michael, I have no PPC toolchain so I have
> not tested this one. Added now.

Just pimping the cross toolchains I build:
	http://kernel.org/pub/tools/crosstool/files/bin/

Yours Tony

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPOZJCAAoJEEsCiJRY75GKlnYP/R3cHYFHtjkMv01X9n2S5jIB
1B/KaznGQiWFBMuR6XN0JE0UINUqGsgsobmZ+o7Yn9JVcUZ6zwweldodE2+RVJZC
3GCL3NfhQjplH+C0iLyzMU+adSkQt9Tp9w8VWTRGsnpPS97fQ/WTgYC/NDSdOiB4
DqEpKAjWiR++k39kJCuaVSQrTgYwwfPQQzoCVcAelUyHuMdyu6tiv6KDfDHSn/fh
etfYg+TP37OvuoRLH705K03G14MyjDbQgxs7VBAJ6RR5I52nUE0Kp/b+v7gq/fvI
VpOzI7ISWqGSEPwVT8oKkiaBJR8AzSMCjvkCZInZE/QT92m6V38Gqw0syMIcaEi/
XyT5HO3PQQ5XZqAbv4FRmWq4ztkiH481A8l7rFFFOYW3uq++aSd9zuJRcxT06X0P
wWeVUSeJH958VGCC8wavhJUYyEVDW1fZfOr0PehPY61CykCaFqcVNtlfq1pbxOvb
PCXaAT8mbq5WPOprz/6eVPC/NHkg35R40VDfMeVSSlg4bxWlPt5f3XIh3XkK8ruz
V3B3gwFsIVV62cmrylHXk//Y2+ViM/+nPk0QtazZ3c7ldvhFKjkf5t+p9lQVgwPR
Squ3wGGpHpqKW3SWlQbn7vKWCJp6LgdEDQrqJKvkfFacANEqJLItNIGHkp175oXP
O391IEilQIVvfBzftiFL
=AM1u
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
