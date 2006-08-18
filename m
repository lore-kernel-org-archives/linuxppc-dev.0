Return-Path: <michael@ellerman.id.au>
Subject: Re: update: consolidated flat device tree code
From: Michael Ellerman <michael@ellerman.id.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1155860626.27466.126.camel@basalt.austin.ibm.com>
References: <1155860626.27466.126.camel@basalt.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Xda7MXW2IxmTkCLoaPFI"
Date: Fri, 18 Aug 2006 10:34:20 +1000
Message-Id: <1155861260.20832.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Xda7MXW2IxmTkCLoaPFI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-17 at 19:23 -0500, Hollis Blanchard wrote:
> Changes:
> - converted some ints to "unsigned", since gcc was generating warnings
> and negative lengths don't make sense in the flat data structure.
> - added ft_set_prop(), which doesn't yet resize properties but will in
> the future.
> - added an explicit copyright statement.
>=20
> Still haven't looked to merge Matt's changes (because I'm busy, the
> current code works for me, and they haven't been accepted in u-boot
> yet).
>=20
> Current users: Xen
> Future users: Mark's Linux bootwrapper code
> Potential users: kexec, u-boot

.. iSeries bootwrapper code?


--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Xda7MXW2IxmTkCLoaPFI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE5QsMdSjSd0sB4dIRArtLAJ99eGhJ9vjAtvUAkrf+a2DvJaCC3QCgjx7I
LwU/bGUHDkuTQgRgh8b6f+Y=
=TR1E
-----END PGP SIGNATURE-----

--=-Xda7MXW2IxmTkCLoaPFI--
