Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4908AB7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 18:08:39 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CC997DDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 18:08:37 +1000 (EST)
Date: Fri, 10 Jul 2009 10:08:30 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bestcomm trouble with NAPI for MPC5200 FEC
Message-ID: <20090710080830.GA3241@pengutronix.de>
References: <4A565423.6010207@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <4A565423.6010207@grandegger.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfgang,

> I'm currently trying to implement NAPI for the FEC on the MPC5200 to
> solve the well known problem, that network packet storms can cause
> interrupt flooding, which may totally block the system. The NAPI

That's great news. Do you happen to have a scenario which reliably triggers=
 the
problem? Then I could do some testing as well. I haven't seen this on our
boards for quite a while, but I'd like to verify.

> - With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
>   FEC and Bestcomm (unfortunately, this does trigger an oops because
>   it's called from the interrupt context, but that's another issue).

+1 for "error handling resets too much"

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpW9v4ACgkQD27XaX1/VRt4egCdFGi06yZwSIKxk7uKrLpD4Kln
8IAAmgIGT1kbXOUn6SMxkfrxSSzrW+E3
=qd09
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
