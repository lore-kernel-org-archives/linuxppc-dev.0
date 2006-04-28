Return-Path: <michael@ellerman.id.au>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
From: Michael Ellerman <michael@ellerman.id.au>
To: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
References: <4450A176.9000008@de.ibm.com>
	<20060427114355.GB32127@wohnheim.fh-wedel.de>
	<1146177388.19236.1.camel@localhost.localdomain>
	<6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
	<84144f020604272332s6101032cy6936096230f3637c@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-85y2jQXXyvqP/sZfaF78"
Date: Fri, 28 Apr 2006 17:11:32 +1000
Message-Id: <1146208292.6307.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-85y2jQXXyvqP/sZfaF78
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-28 at 09:32 +0300, Pekka Enberg wrote:
> Hi Heiko,
>=20
> On 4/28/06, Heiko J Schick <info@schihei.de> wrote:
> > The problem I see with pr_debug() is that it could only activated via
> > a compile flag. To use the debug outputs you have to re-compile /
> > compile your own kernel.
>=20
> Do you really need this heavy debug logging in the first place? You
> can use kprobes for arbitrary run-time inspection anyway, so logging
> everything seems wasteful.

Yeah, I really don't think you want to be running with that kind of
debugging gunk in a production kernel. Is someone who can't build their
own kernel really going to be able to make sense of the output?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-85y2jQXXyvqP/sZfaF78
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEUcAkdSjSd0sB4dIRAlELAKCiEQ/iduYNhhgzQA0ZxpWUwqFyvgCfXAJZ
OKiZInityOjb9rLsiQfSxxg=
=NS3r
-----END PGP SIGNATURE-----

--=-85y2jQXXyvqP/sZfaF78--
