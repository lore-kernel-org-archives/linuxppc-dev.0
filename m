Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fo8sGo9ThhkpvSSzeUOp"
Date: Tue, 03 Apr 2007 12:42:13 +1000
Message-Id: <1175568133.16182.15.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fo8sGo9ThhkpvSSzeUOp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-02 at 19:36 +0200, Segher Boessenkool wrote:
> >>> The old 2.6.16 kernel handled memory statically and it was shown in=20
> >>> the
> >>> device tree. The current kernel deals with the hypervisor and=20
> >>> hotplugs
> >>> the memory, so we should just ignore anything that's reported in the
> >>> device-tree. This enables the current kernel to be booted from 2.6.16
> >>> without evil hacks in head_64.S to override the device-tree.
> >>
> >> Surely when you are booted you already have some
> >> memory plugged for you -- shouldn't that memory be
> >> in the device tree?
> >
> > See ps3_mm_init(), called from _probe_.
>=20
> Yes sure, the hypervisor has given you some memory
> already, and it tells you about it.

My point was it's not coming out of the device tree, it's just manually
lmb_add'ed.

> My question remains: shouldn't Linux get that
> information from the device tree, instead?  The
> bootwrapper or bootloader can put it there.

Yes it _should_, but it doesn't.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fo8sGo9ThhkpvSSzeUOp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGEb8FdSjSd0sB4dIRAnGAAJ9RhmRV/d/VwdoAWUyK+TH5/pAHAACgvNuB
fm74wyHVevum8dIhy+jnQf8=
=NpK4
-----END PGP SIGNATURE-----

--=-fo8sGo9ThhkpvSSzeUOp--
