Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Michael Ellerman <michael@ellerman.id.au>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20070319105357.964696000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nluF4xHd5g+n1gVoNvAD"
Date: Wed, 02 May 2007 15:02:23 +1000
Message-Id: <1178082143.5296.9.camel@concordia.ozlabs.ibm.com>
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


--=-nluF4xHd5g+n1gVoNvAD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 11:53 +0100, Johannes Berg wrote:
> plain text document attachment (001-time-resume.patch)
> This patch removes the time suspend/restore code that was done through
> a PMU notifier in arch/platforms/powermac/time.c.
>=20
> Instead, introduce arch/powerpc/sysdev/timer.c which creates a sys
> device and handles time of day suspend/resume through that.
>=20
> This should probably be replaced by using the generic RTC framework
> but for now it gets rid of the arcane powermac specific hack.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This seems to break prep_defconfig:

timer.c:(.text+0x28c): undefined reference to `rtc_tm_to_time'
timer.c:(.text+0x38c): undefined reference to `rtc_tm_to_time'
make[1]: *** [.tmp_vmlinux1] Error 1

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nluF4xHd5g+n1gVoNvAD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOBtfdSjSd0sB4dIRAr6LAJ4gexRXqx+a6o/oJaktAMa47eRDdACeJip+
HL2H1GuUsThag75JAZVKujU=
=y20h
-----END PGP SIGNATURE-----

--=-nluF4xHd5g+n1gVoNvAD--
