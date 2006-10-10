Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (mail.isohunt.com [69.64.61.20])
	by ozlabs.org (Postfix) with ESMTP id F1FBC679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 22:16:10 +1000 (EST)
Date: Tue, 10 Oct 2006 05:09:23 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix windfarm platform device usage
Message-ID: <20061010120923.GA1516@curie-int.orbis-terrarum.net>
References: <1160444851.32237.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <1160444851.32237.41.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2006 at 11:47:31AM +1000, Benjamin Herrenschmidt wrote:
> The windfarm code uses a struct device_driver instead of
> platform_driver, which can cause crashes if any of the callbacks are
> called (like on module removal). This fixes it.
Thanks! This makes my windfarm work a lot easier!
(I am still working on it, just very slowly).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFK41zPpIsIjIzwiwRAhYsAJ9eHBnfo0sPA4SAfYwXJE+tUad5EwCfcn8E
6DMif6CiI/AvDjf5zF6olLQ=
=L1PJ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
