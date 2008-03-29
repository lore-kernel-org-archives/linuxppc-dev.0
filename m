Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 39B46DDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 09:51:22 +1000 (EST)
Date: Sun, 30 Mar 2008 10:51:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] [POWERPC] 85xx: Add support for relocatble kernel
	(and booting at non-zero)
Message-Id: <20080330105112.5761189a.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0803290834300.4672@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0803290834300.4672@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__30_Mar_2008_10_51_12_+1100_0r1Wwiwfv8921wQY"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__30_Mar_2008_10_51_12_+1100_0r1Wwiwfv8921wQY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Sat, 29 Mar 2008 08:34:49 -0500 (CDT) Kumar Gala <galak@kernel.crashing.=
org> wrote:
>
> The alignment compile check broke building on ppc32 (pmac, etc) since
> CONFIG_PHYSICAL_ALIGN isn't defined there.

OK, so that explains why linux-next failed to build for 32 bit powerpc
yesterday.  In the future, please do not put things that are this
experimental into your powerpc-next branch as it impacts the testing of
everything else that is destined for the next merge window ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__30_Mar_2008_10_51_12_+1100_0r1Wwiwfv8921wQY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7tX3TgG2atn1QN8RAsWuAJ9BaBK4bJ7cgTmlQJssU27qss8umACghTB8
FLvI13pcQ79B6nW4ndPH0Kw=
=wjX6
-----END PGP SIGNATURE-----

--Signature=_Sun__30_Mar_2008_10_51_12_+1100_0r1Wwiwfv8921wQY--
