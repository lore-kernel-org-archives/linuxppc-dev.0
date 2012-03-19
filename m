Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABDEEB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 19:37:45 +1100 (EST)
Date: Mon, 19 Mar 2012 09:37:24 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH][RFC] mpc52xx, common: setup port_config and cdm
 settings through DTS
Message-ID: <20120319083724.GA2484@pengutronix.de>
References: <1303193045-20111-1-git-send-email-hs@denx.de>
 <20120319002507.275d73ef@wker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <20120319002507.275d73ef@wker>
Cc: Heiko Schocher <hs@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2012 at 12:25:07AM +0100, Anatolij Gustschin wrote:
> Hi Heiko,
>=20
> On Tue, 19 Apr 2011 08:04:05 +0200
> Heiko Schocher <hs@denx.de> wrote:
>=20
> > If firmware does not setup the "GPS Port Configuration Register"
> > and the "CDM 48MHz Fractional Divider Configuration Register",
> > it can be corrected through DTS.
> >=20
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > cc: devictree-discuss@lists.ozlabs.org
> > cc: linuxppc-dev@lists.ozlabs.org
> > cc: Grant Likely <glikely@secretlab.ca>
> > cc: Wolfgang Denk <wd@denx.de>
> > ---
> >  .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   16 +++++++++++
> >  arch/powerpc/platforms/52xx/mpc52xx_common.c       |   27 ++++++++++++=
++++++++
> >  2 files changed, 43 insertions(+), 0 deletions(-)
>=20
> Applied slightly modified patch to mpc5xxx next.

Given that the patch was sent nearly one year ago and it even got
modified, could please resend it to the list before applying?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9m8EQACgkQD27XaX1/VRt8EQCfUj46ruNEmHATjiyNIzNzh8dX
5BYAoJFr7y3mf18ACp4YXSOR+P4LXro+
=FPtM
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
