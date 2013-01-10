Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EDF52C0291
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 21:08:53 +1100 (EST)
Date: Thu, 10 Jan 2013 12:08:35 +0200
From: Felipe Balbi <balbi@ti.com>
To: <leoli@freescale.com>, <gregkh@linuxfoundation.org>,
 <linux-usb@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Message-ID: <20130110100835.GB28920@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Some recent patch has caused fsl_mxc_udc.c driver to fail compilation
because it can't find <mach/hardware.h> anymore.

I would like this to be fixed still during this -rc cycle.

Thank you

--=20
balbi

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7pMjAAoJEIaOsuA1yqRESewP/34cZGKSCRKD6OUpal7bi4f3
2K0eVrt1k8A6nYUfgf2rUuQhtvGjAHtfPQg5Ml92/MBe+eH/0bIqAq6Lxv6vF6h1
6Bp9IkX2OH7Xlq4fm+PVADMHlTcNGH9CD6tONNwng01bRhungmdQKvY6zmsaUWT4
pXvloftJyp4z8ULMU3pHtUQqUblacJrdtsNaxUdLXo7j9NbF9O81KD66YjO3djp5
9dHTo7l4nPamS8CzxQ4QWtB7a1XRvkwYGgJGg1JCU+BwrZxaqH1kVznqboZzR4Sw
32ui8zp+8jX1SfDr1GBdKjVAc4duG3GR8uaFLM9d/LWVax9aOD91CS6TkbkOvHMZ
dsYCkRgbUIIJyMqduL1BSFBnhfghIfqXA4xVXPobSsss4Vvy7fKwfNMti5+ECfHU
ZYbkXhA/WufPSG0IorVUEOBnsIspQkrDRms0RkHAp7Il25qOe4lR5ooFStZY6C6/
pncP4LLeDBnvhIX6hlnSPfPdqiZDSH3wdhdxXYIQ+X2lrL7lE6Tz3xgtDOXvlOT0
HFrBukDc3v3EK/58OzX4JonHgaHs+Bkc0p3fFH0hM8ALLD4cBqgcLOOMU8T7pfoO
9o3dyqQwyEuvdTzzzQN0NaU6OuiIEPX/+HyARRwBc1SimtIvS07crhD3YPZSLv4E
x7qOwSIubwmljXoB3GXL
=mf0L
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
