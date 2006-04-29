Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2B8BA679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 13:42:11 +1000 (EST)
Date: Sat, 29 Apr 2006 13:42:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: sign extension for 32bit syscalls on ppc64
Message-Id: <20060429134204.2619adcd.sfr@canb.auug.org.au>
In-Reply-To: <20060429131640.6f79e0d3.sfr@canb.auug.org.au>
References: <20060428131254.GA507@lst.de>
	<17490.42497.351114.712494@cargo.ozlabs.ibm.com>
	<20060429113059.150cadd6.sfr@canb.auug.org.au>
	<17490.53377.898206.21369@cargo.ozlabs.ibm.com>
	<20060429131640.6f79e0d3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Apr_2006_13_42_04_+1000_K/+Qp8lHju_qooJB"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Apr_2006_13_42_04_+1000_K/+Qp8lHju_qooJB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Apr 2006 13:16:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> AT_FDCWD (actually -100, sorry) is not protected by __KERNEL__ in
> include/linux/fcntl.h and sys_openat does not stop it being passed, so I
> assume it is part of the user ABI.

And AT_FDCWD is mentioned in the Solaris documentation for openat(2).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Apr_2006_13_42_04_+1000_K/+Qp8lHju_qooJB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUuCMFdBgD/zoJvwRAvfLAKCcl3/6h15ASa237OIPAsviMbjfUwCcCpDK
RPCiygppAvEPm6/sQyZlJE0=
=QmPU
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_13_42_04_+1000_K/+Qp8lHju_qooJB--
