Return-Path: <balbi@ti.com>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
 [74.125.149.203])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1A2D1007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:47:22 +1100 (EST)
Received: by mail-yx0-f179.google.com with SMTP id m6so192799yen.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:47:19 -0800 (PST)
Date: Thu, 24 Nov 2011 11:47:17 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v2] USB: fsl_udc_core: use usb_endpoint_xfer_isoc to
 judge ISO XFER
Message-ID: <20111124094716.GS3352@legolas.emea.dhcp.ti.com>
References: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
In-Reply-To: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
Cc: gregkh@suse.de, linux-usb@vger.kernel.org, mina86@mina86.com, balbi@ti.com,
 linuxppc-dev@lists.ozlabs.org, stable@kernel.org, hzpeterchen@gmail.com
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2011 at 09:55:45AM +0800, Peter Chen wrote:
> Some ISO gadgets, like audio, has SYNC attribute as well as
> USB_ENDPOINT_XFER_ISOC for their bmAttributes at ISO endpoint
> descriptor. So, it needs to use usb_endpoint_xfer_isoc to judge
> ISO XFER.
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

applied, thanks

--=20
balbi

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzhKkAAoJEIaOsuA1yqREHLQQAIn2oTaHZbFumuE6Fp7O8OXI
8sCuUaJcauD/Qx3HKOapd1QHkzbqTcfUCZQBDcfB99lrmeGDQGmRsh7avtuI9Ol5
cSr5NkiWRhM4Aw3MPc47jwq2RYfgBUTvj1OCj85GA9N3Onv8p2M9Rl0hENEuRuQX
fbj9iwggY0OodELD/fFxB7vI5q+cUOwjQypQXyrj24e34ZcKvEtPRUPLjIvH2mrn
76yTziQuQD8HCU1LbaLqlUHEMKSX+yGQke0LVaDTgyIyWONgxHLICKNfFtr6as1B
hLqW8ojX0VoGUIOw1rY0JoPGhwVXehx/QrWccqLqJJkMZRYv3tp5CViZVNPHx2v8
TueERnI8WRO1ih3d7gLjZINgTxIQPy5sj42Agi52rGYzDfLGhNJ3Nldb4DQfP2ZZ
5tmJ1TToJm5MwkRx6bOUVxQ3VKgjnsULcGdUQRbBZzFvFRgD2xJz3XB5MyW5622a
SRxI1ypILu8lazG7X93Inj59MetBqAj4gLsMF2LtfG1u+tbjBqdv7cg2uwLJ5NuP
EReH+eQ4Ee1ORDNDZjTc7YyAMrpPn2rNNevZqxBFt7gR9zp4c8ptMvKxak3P4ShH
wY8XAgJGuFavVBFv9SY6zEDiLLre06Nt6PRK5uwWx+iiyN2EzGst6tZnHH4kIGkl
44/I5tn18pmREDffLnKm
=SCFO
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
