Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85CF5DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:32:43 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Keep track of emulated instructions if
	debugfs is enabled
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0905081611130.7964@vixen.sonytel.be>
References: <alpine.LRH.2.00.0905081611130.7964@vixen.sonytel.be>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-WonCJdrtJ8M9FA0uT7eB"
Date: Mon, 11 May 2009 12:32:41 +1000
Message-Id: <1242009161.7767.38.camel@concordia>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WonCJdrtJ8M9FA0uT7eB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-05-08 at 16:15 +0200, Geert Uytterhoeven wrote:
> Counters for the various classes of emulated instructions are available u=
nder
> /sys/kernel/debug/powerpc/emulated_instructions (assumed debugfs is mount=
ed on
> /sys/kernel/debug).  Optionally (controlled by
> /sys/kernel/debug/powerpc/emulated_instructions/do_warn), rate-limited wa=
rnings
> can be printed to the console when instructions are emulated.
>=20
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> Tested on ppc64 (ps3) and ppc32 (sequoia) using mfpvr.
>=20
> v3:
>   - add generic unaligned
>   - switch from sysfs + sysctl to debugfs. All virtual files now show up =
under
>     /sys/kernel/debug/powerpc/emulated_instructions (assumed debugfs moun=
ted on
>     /sys/kernel/debug)
>   - enable the printing of rate-limited warnings by writing a non-zero va=
lue to
>     /sys/kernel/debug/powerpc/emulated_instructions/do_warn
>   - switch from per-CPU to system-wide counters
>   - always use 32-bit counters (was 64-bit on ppc64)
>   - counters are writable, i.e. can be reset (by root)

Nice :)

My only query is whether it needs its own CONFIG option. Some folks
might want other DEBUG_FS things but not this?

cheers


--=-WonCJdrtJ8M9FA0uT7eB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoHjkkACgkQdSjSd0sB4dIk5gCdEMrFpOLyCnD+2qHItwmCYfXG
d3wAniu9B0wKwBkLBUPX0MP/oCddpvJd
=zuOc
-----END PGP SIGNATURE-----

--=-WonCJdrtJ8M9FA0uT7eB--
