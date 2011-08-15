Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83EEDB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Aug 2011 02:14:03 +1000 (EST)
Message-ID: <4E4945B9.2020201@pengutronix.de>
Date: Mon, 15 Aug 2011 18:13:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v12 3/6] flexcan: Fix up fsl-flexcan device tree binding.
References: <1313138752-24006-1-git-send-email-holt@sgi.com>
	<1313138752-24006-4-git-send-email-holt@sgi.com>
	<20110815150357.GM4926@sgi.com>
In-Reply-To: <20110815150357.GM4926@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3856E2123D9DE0B80222F236"
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3856E2123D9DE0B80222F236
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/15/2011 05:03 PM, Robin Holt wrote:
> Earlier, you had asked for a more specific name for the compatible
> property of the Freescale flexcan device.  I still have not gotten a
> more specific answer.  Hopefully Marc can give you more details about
> the flexcan implementations.

There are at least 2 versions of the flexcan ip core in the wild. Due to
lack of version numbers or other names I call them old and new here :).

The newer one supports rx fifo mode, whereas the older one doesn't. The
mainline flexcan driver just supports the new core [1]. The older core
is found on coldfire processors. I don't know if there are coldfire cpus
with the new flexcan core, too. The driver can be adopted to the old
core if needed.

The first cpus with the new core I got in touch with was the mx35
(arm11) and mx25 (arm9) both at the same time. Ask fsl which one was
released first. After this there was mx28 (arm9) and there should be an
mx53 (coretexa8) with flexcan too.

> Other than an agreement on the compatible property, I believe we have
> agreement on all the other code changes in these patches.  Is this chan=
ge
> acceptable as is and if we get a better resolution on the fsl,flexcan
> name later, we can update the documentation and driver then?

cheers, Marc

[1] http://lxr.linux.no/linux+v3.0.1/drivers/net/can/flexcan.c#L871

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3856E2123D9DE0B80222F236
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5JRbwACgkQjTAFq1RaXHMlAgCeLCfI0CuYJRapp88vYkdlauBf
arUAoI6CTN3jhmmFsf355McyGVf7sSV4
=YPDm
-----END PGP SIGNATURE-----

--------------enig3856E2123D9DE0B80222F236--
