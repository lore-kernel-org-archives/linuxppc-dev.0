Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <DBBE020D-0BFA-44EC-B1C9-D33F96CC924D@kernel.crashing.org>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
	<1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
	<C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
	<1166125466.31351.14.camel@localhost.localdomain>
	<DBBE020D-0BFA-44EC-B1C9-D33F96CC924D@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5o+sdCEIvVfT/r9Xe+Yu"
Date: Fri, 15 Dec 2006 12:51:40 +1100
Message-Id: <1166147500.4892.18.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5o+sdCEIvVfT/r9Xe+Yu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-15 at 02:47 +0100, Segher Boessenkool wrote:
> >>> "msi-ranges" is ambiguous, are the ranges available or reserved?
> >>>
> >>> How about "msi-available-ranges" :D
> >>
> >> The property describes vectors that are not (yet) in use by
> >> the hardware; so let's do "available-vectors"?
> >
> > If we are going to be pedantic, it should be msi-available-sources :-)
>=20
> But a) it's not really MSI-only, and b) they're not source
> numbers, but delivery vector numbers (yeah, those are almost
> the same on U3/U4, but hey).

OK I'm gonna lock you two in a padded room, and whoever comes out alive
gets to name the property, OK? Then let me know what it is and I'll
update the freakin code!

:D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5o+sdCEIvVfT/r9Xe+Yu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgf+sdSjSd0sB4dIRAgnDAKCYy8P45FPPthHZUL8DDsE8yjf9hACfcMST
T8uiUsXxqJHQ/gexS2CBgQg=
=1JL6
-----END PGP SIGNATURE-----

--=-5o+sdCEIvVfT/r9Xe+Yu--
