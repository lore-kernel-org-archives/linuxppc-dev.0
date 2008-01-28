Return-Path: <michael@ellerman.id.au>
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200801282119.41403.arnd@arndb.de>
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
	<1201394998.6659.3.camel@concordia> <200801282119.41403.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-t/ty3qcRA57xxClankzJ"
Date: Tue, 29 Jan 2008 09:08:20 +1100
Message-Id: <1201558100.17702.0.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-t/ty3qcRA57xxClankzJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-01-28 at 21:19 +0100, Arnd Bergmann wrote:
> On Sunday 27 January 2008, Michael Ellerman wrote:
> > Can you grab these four assuming there's no objections in the meantime.
> >=20
> > http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16430
> > http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16433
> > http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16434
> > http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D16437
> >=20
>=20
> Yes, they all look good to me, you can add an
> 'Acked-by: Arnd Bergmann <arnd@arndb.de>' if you like.
>=20
> What about your other series that adds the linear iommu mapping
> for cell blades? Are you still waiting for more feedback and
> testing on that, or can it also go in?

I'd like to clean it up a bit, split the big patch up a bit. I'll try to
do that today or tomorrow. And more testing would definitely be good,
but that's a little tricky from LCA :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-t/ty3qcRA57xxClankzJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHnlJUdSjSd0sB4dIRAuZqAKCDQN/rCO8+6fIwtX2QTKUQ5idZHACgtxYW
SsWDHWHTgYTNiLoBvToVd5g=
=CiHW
-----END PGP SIGNATURE-----

--=-t/ty3qcRA57xxClankzJ--
