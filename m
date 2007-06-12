Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E2229DDED8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 14:02:34 +1000 (EST)
Date: Tue, 12 Jun 2007 14:02:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [patch 01/10] powerpc: split out CPU specific options into a
	new Kconfig file
Message-Id: <20070612140214.1a7dfd9d.sfr@canb.auug.org.au>
In-Reply-To: <20070611233353.602822721@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.602822721@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Jun_2007_14_02_14_+1000_Bt1+9UDPzaA1zhDi"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Jun_2007_14_02_14_+1000_Bt1+9UDPzaA1zhDi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jun 2007 01:28:25 +0200 arnd@arndb.de wrote:
>
> -config VIRT_CPU_ACCOUNTING
> -	bool "Deterministic task and CPU time accounting"

I am not sure that this belongs with all the rest.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Jun_2007_14_02_14_+1000_Bt1+9UDPzaA1zhDi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbhrKFdBgD/zoJvwRAquLAKCUYs+dBbH9EXWWtfqAYkSwIAh7JwCgguYq
0GdOd/lB5EgfbWJoesQP3e4=
=2K43
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Jun_2007_14_02_14_+1000_Bt1+9UDPzaA1zhDi--
