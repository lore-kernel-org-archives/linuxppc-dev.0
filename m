Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v4] Make instruction dumping work in real mode.
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070927183855.GA18226@loki.buserror.net>
References: <20070927183855.GA18226@loki.buserror.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fOJ0AKP9b68+6TDwZd/W"
Date: Fri, 28 Sep 2007 08:57:26 +1000
Message-Id: <1190933846.6601.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fOJ0AKP9b68+6TDwZd/W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-27 at 13:38 -0500, Scott Wood wrote:
> On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happen=
s
> that leads to a register dump, the kernel currently prints XXXXXXXX becau=
se
> it doesn't realize that PC is a physical address.
>=20
> This patch checks the state of the IMMU, and if necessary converts PC int=
o a
> virtual address.

IMMU ?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fOJ0AKP9b68+6TDwZd/W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/DVWdSjSd0sB4dIRArCTAJ9DAYRpAH1KbgD28mvy0BURSORXlgCgqL/g
gBjrGNdayQDgOJA5wbhW/Fs=
=ZKR8
-----END PGP SIGNATURE-----

--=-fOJ0AKP9b68+6TDwZd/W--
