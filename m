Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60D75104796
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2012 04:02:18 +1100 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] Implement GET_IP/SET_IP for powerpc architecture.
Date: Thu, 2 Feb 2012 12:02:13 -0500
References: <20120202144125.GA6221@linux.vnet.ibm.com>
 <201202021128.49188.vapier@gentoo.org>
 <20120202163659.GD31984@linux.vnet.ibm.com>
In-Reply-To: <20120202163659.GD31984@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11996328.L8tORn9GJu";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <201202021202.16848.vapier@gentoo.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart11996328.L8tORn9GJu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 02 February 2012 11:36:59 Srikar Dronamraju wrote:
> * Mike Frysinger <vapier@gentoo.org> [2012-02-02 11:28:46]:
> > On Thursday 02 February 2012 09:41:25 Srikar Dronamraju wrote:
> > > +#define profile_pc(regs) GET_IP(regs)
> >=20
> > pretty sure you don't need this as asm-generic/ptrace.h already has a
> > definition for you
>=20
> On ppc64, profile_pc is an extern function if CONFIG_SMP is set.
> else its same as whats defined in asm-generic/ptrace.h

the code i quoted was from !CONFIG_SMP
=2Dmike

--nextPart11996328.L8tORn9GJu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPKsGYAAoJEEFjO5/oN/WBDSAQAJoRkJ0iZH0GXu6Ud17AYsV/
OXtDbGZKNZd8c1I/QRacXA8j4R0s0ABG4WZg9Q1NSk+VPF4biFjAXlj3VtwyjERf
Ikrcz15Gj0FknFZ1gyLghHpI+tsmfx3+SpQSGNeXSJvc2ZPcFw92ZMpMhRrbB5/R
n+opRJPFt3ba8L9PV105kbyWOA4YCx9gtbR/bDMc514rOTMMeBYy6h1nO8nzW5q0
IoIUuRZEW6nMdoct7uYVtJC08TN3M7b2Un7pgcK0Qi28ypFGDjtdtMi7h2O22NnA
7JrsWxAT5aXb4ZvGfo/yp3ggqkp0vTwWUWkgaESAyiieSZkrAsg+hG6Xo4p4LufK
fOX35VM6tKwN8hljgM2BQRazDH1QAUr0SodtAWTJF/IhHKgCdaunIz10ga5R6cx/
Tg9kMBlV2ArFClJ4ngJn0OgDGRi7yVD+MUDG2XbhQOZMDq3TThp/wgElpbLqI2p8
eGPEfDMGKjZRqjS7T/lQLrRktYeTC3wMhuxpz8T4G37e70NhsJ4o4DgSn4XxBoUq
6HBEjuMOil1IKq9a5sV04dpBo4qSRWUG0cY/dhAl7q2CdJBVKKyN3hPjrnaSdP2w
URFSbmVlWPm9J3e1D6uCPq/C+xwOww3PG76MEDfZcAUvAYx/d4RmJjCS9SImU6vB
/gohvFOOpX8mFUc9XSWd
=zMFp
-----END PGP SIGNATURE-----

--nextPart11996328.L8tORn9GJu--
