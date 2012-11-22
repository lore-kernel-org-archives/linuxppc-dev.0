Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 318B42C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 08:50:00 +1100 (EST)
Date: Thu, 22 Nov 2012 22:49:15 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
Message-ID: <20121122214915.GD14851@pengutronix.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
 <20121120144621.5d2c213a@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
In-Reply-To: <20121120144621.5d2c213a@endymion.delvare>
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, "Mark M. Hoffman" <mhoffman@lightlink.com>,
 linux-omap@vger.kernel.org, Bill Pemberton <wfp5p@virginia.edu>,
 linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, Olof Johansson <olof@lixom.net>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > needed.
>=20
> As mentioned on the lm-sensors list for hwmon patches already, I think
> it would be much clearer to not split __devexit, __devexit_p, __devinit
> etc. removal into separate patches. One patch per subsystem would be
> easier to review and apply. If patches grow too large then you'd rather
> split in a different direction, for example drivers/i2c/muxes vs.
> drivers/i2c/busses or even grouped by related bus drivers (see entries
> "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> MAINTAINERS for examples of meaningful groups.)

I agree with Jean here. Is there a V2 planned? With a change like this?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCundsACgkQD27XaX1/VRvVDQCfb648pSwyIGE88RY9RW4sDgf2
fpMAn2qfmShNxBl1Oz5Jg8yV6GDi3TcE
=yTbX
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
