Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CCD014009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 05:12:17 +1000 (EST)
Message-ID: <5354175B.3070109@pengutronix.de>
Date: Sun, 20 Apr 2014 20:52:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
 leoli@freescale.com, balbi@ti.com, michal.simek@xilinx.com
Subject: Re: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
In-Reply-To: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pmvvGVFxVpXF3EStVhMQPAHlmlk8pKBL1"
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@freescale.com>, kalluripunnaiahchoudary@gmail.com,
 kpc528@gmail.com, Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pmvvGVFxVpXF3EStVhMQPAHlmlk8pKBL1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2014 06:27 PM, Punnaiah Choudary Kalluri wrote:
> Zynq soc contains a dual role usb controller and this IP is from synops=
ys. We
> observed that there is driver available for this controller from freesc=
ale and
> decided to reuse this driver for zynq use.

Have a look drivers/usb/chipidea. It's maintained by Peter Chen (Cc'ed)
and is in better shape than the freescale driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pmvvGVFxVpXF3EStVhMQPAHlmlk8pKBL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNUF18ACgkQjTAFq1RaXHOe/gCfaQTcIGRWutnvCgxpLF5zt/zz
ckwAniLxhuJdXwoFWp2o59jgg1v8X8GS
=x9vH
-----END PGP SIGNATURE-----

--pmvvGVFxVpXF3EStVhMQPAHlmlk8pKBL1--
