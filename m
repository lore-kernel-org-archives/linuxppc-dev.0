Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powermac: proper time of day after resume
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1170357390.4036.9.camel@johannes.berg>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-039oaZ8Krv9/h3LpkBfo"
Date: Sat, 03 Feb 2007 13:41:34 +1100
Message-Id: <1170470494.30263.0.camel@concordia.ozlabs.ibm.com>
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


--=-039oaZ8Krv9/h3LpkBfo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-01 at 20:16 +0100, Johannes Berg wrote:
> This patch converts the time restore code from a PMU notifier to a regula=
r
> sys device so any powerpc platform will use it.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> ---
>  arch/powerpc/Kconfig                           |    5 +
>  arch/powerpc/kernel/Makefile                   |    1
>  arch/powerpc/platforms/powermac/time.c         |   38 -------------
>  mb-wireless/arch/powerpc/kernel/time_suspend.c |   70 ++++++++++++++++++=
+++++++

Would it be better in arch/powerpc/sysdev perhaps? :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-039oaZ8Krv9/h3LpkBfo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFw/ZedSjSd0sB4dIRAvCUAJsGS7ezc6aHXodEHKeIHGawLYiK4QCdGTrF
HdOCOhpPqnhDg7db7KZmNgA=
=zmhy
-----END PGP SIGNATURE-----

--=-039oaZ8Krv9/h3LpkBfo--
