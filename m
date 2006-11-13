Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] make git ignore new wrapper generated files
From: Michael Ellerman <michael@ellerman.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20061113214149.GA9157@mag.az.mvista.com>
References: <20061110180830.419c28bd.kim.phillips@freescale.com>
	<1163451020.5463.10.camel@localhost>
	<20061113214149.GA9157@mag.az.mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2UgqqIakkW0fLWccTULl"
Date: Tue, 14 Nov 2006 09:45:59 +1100
Message-Id: <1163457959.8048.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2UgqqIakkW0fLWccTULl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-13 at 14:41 -0700, Mark A. Greer wrote:
> On Mon, Nov 13, 2006 at 02:50:20PM -0600, Matthew McClintock wrote:
> > On Fri, 2006-11-10 at 18:08 -0600, Kim Phillips wrote:
> > > The new 'wrapper' code generates files that git should ignore;
> > > add them to .gitignore.
> >=20
> > Why don't we just add these files to be cleaned correctly?
>=20
> Its cleans up 'git status' in a tree that you've built.

Don't build in your source tree ..

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2UgqqIakkW0fLWccTULl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWPWmdSjSd0sB4dIRAkO0AJ9b4H29+h0/brJh08IFpCJRxKC3zwCeIrnt
ArLw9SR1eDWjd3aAjvdkZ/w=
=hnIy
-----END PGP SIGNATURE-----

--=-2UgqqIakkW0fLWccTULl--
