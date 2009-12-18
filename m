Return-Path: <vitb@kernel.crashing.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9693DB7C7D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:11 +1100 (EST)
Date: Fri, 18 Dec 2009 08:50:35 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091218085035.272167f2@vitb-lp>
In-Reply-To: <20091217093434.GA19931@pengutronix.de>
References: <20091216024730.455b90fd@vitb-lp>
	<20091217093434.GA19931@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/93xGAP._kDSFQ5.ZGo4MyNy";
	protocol="application/pgp-signature"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/93xGAP._kDSFQ5.ZGo4MyNy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 Thu, 17 Dec 2009 10:34:34 +0100
Wolfram Sang <w.sang@pengutronix.de> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Wed, Dec 16, 2009 at 02:47:30AM +0300, Vitaly Bordug wrote:
> >=20
> > From: Heiko Schocher <hs@denx.de>
> >=20
> > This driver provides (read/write) access to the
> > U-Boot bootcounter via PROC FS or sysFS.
> >=20
> > in u-boot, it uses a 8 byte mem area (it must hold the value over a
> > soft reset of course), for storing a bootcounter (it counts many
> > soft resets are done, on hard reset it starts with 0). If the
> > bootcountvalue exceeds the value in the env variable "bootlimit",
> > and alternative bootcmd stored in the env variable "altbootcmd" is
> > run.
>=20
> Hmm, both in my inbox and in patchwork, the patch seems line-wrapped.
> Also, there are a few printk without loglevel. As probe has access to
> a device structure, dev_* should be a nice option here.
>=20
OK, makes sense.

-Vitaly
> Regards,
>=20
>    Wolfram
>=20

--Sig_/93xGAP._kDSFQ5.ZGo4MyNy
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAksrGDIACgkQrAly3uc5iB1N6QCgl9XzUTlSQzcDHJbTmkbkorou
R9UAn3ZxwDOB1ZdTmx2YOhGcYWri6BzH
=OylC
-----END PGP SIGNATURE-----

--Sig_/93xGAP._kDSFQ5.ZGo4MyNy--
