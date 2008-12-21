Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Make default kexec/crash_kernel ops implicit
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081216162305.GB21749@oksana.dev.rtsoft.ru>
References: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
	<20081216162305.GB21749@oksana.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ng7SsjqV9DKyyiH9PQ2i"
Date: Mon, 22 Dec 2008 10:08:42 +1100
Message-Id: <1229900922.8269.15.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ng7SsjqV9DKyyiH9PQ2i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-16 at 19:23 +0300, Anton Vorontsov wrote:
> This patch removes need for each platform to specify default kexec and
> crash kernel ops, thus effectively adds a working kexec support for most
> boards.
>=20
> Platforms that can't cope with default ops will explode in some weird
> way (a hang or reboot is most likely), which means that the board's
> kexec support should be fixed or blacklisted via dummy _prepare callback
> returning -ENOSYS.

But where is the patch to do this?

The chance of kexec working on some random machine that's never been
tested is pretty slim, every driver needs to be aware its hardware might
be in a weird state, so enabling it by default is not a good idea IMHO.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ng7SsjqV9DKyyiH9PQ2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklOzHoACgkQdSjSd0sB4dLimQCgw5F4tcyrwyf36QZYaXVgvFcq
VgsAnivT3D4bhlNzCC1qSTD7XY7AtOyO
=p4kI
-----END PGP SIGNATURE-----

--=-ng7SsjqV9DKyyiH9PQ2i--
