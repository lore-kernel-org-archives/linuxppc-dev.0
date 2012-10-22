Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FC1F2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 19:00:24 +1100 (EST)
Date: Mon, 22 Oct 2012 10:54:23 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
Message-ID: <20121022075423.GB14033@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
 <20121019103039.GF11191@arwen.pp.htv.fi>
 <1350643608.3709.78.camel@mars>
 <20121019104416.GH11191@arwen.pp.htv.fi>
 <1350760347.3669.3.camel@mars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
In-Reply-To: <1350760347.3669.3.camel@mars>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org, balbi@ti.com,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 20, 2012 at 09:12:27PM +0200, Christoph Fritz wrote:
> On Fri, 2012-10-19 at 13:44 +0300, Felipe Balbi wrote:
> > > I thought about this too but wasn't able to use chipidea with
> > > MXC_EHCI_INTERNAL_PHY as it's called in fsl_udc.
> >=20
> > that's a matter of writing the PHY driver, right ;-) It has nothing to
> > do with chipidea, actually :-)
>=20
> Okay, I'll do. But then we should purge the old buggy fsl_udc.

I'm all for that. We shouldn't have multiple copies of a single driver
hanging around.

cheers

--=20
balbi

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhPuvAAoJEIaOsuA1yqREHpoP/02g2L8dSBFq+qIYTKqbacux
5D46t4R9ah7KIDeqHuv7Tl1oCf6xiT9cAMMEOh+/OVXbom4CgqkCh3HrWOQHEYMm
1SwBaEmuoL4wXxiwf3rqFkaTBE4hZTq3eZ6kq+NfVaxqQnWpOBMxK+S4nm1hsxBo
HaFRdinYga06yA1NT693Uifm0Pn9O/Vhi/pnKnYVG2BdNJ67Nj87XwA2dos4+fae
TjS1IyIlqSix8Ana0Vqz4P0DjrNttTSoEyvPORMJjCztVhZ9ej/sDaUofP+UUkM5
V2EZoYT3zFWAptCKQJJF3ELTJDK36tC2EGZ6gxJY+oKX4Wm7IMEL2dqX6EVvyNfz
f3sdH+RSPaqTxrwU1ZqxZcuV9Xd3EZI2WPu8CMzGYZRw/GQcTrW31chrb+xbzxpb
F5F0PLTiYF7gdTNVEcA7JkiOwygE8vYua4UI35WPfzz2qhapZQKEDlMUxAL8f/aA
Q6Vv4AK8MNKvW+8O/x35dtD5kytpMh568bG8D5Em0XNBYV138Yxh20m6xoLoq0Bt
7NxDrzX+elTyCUxoF8T2xBoOsgUm/XivRno8eEtqR6H8bi/lyVBNHSM7mMVLFw7T
rf6SwfNMTR2qIkym6VhcSMMb6FmcnuJwsvUCtDPNGXisYGCH5KQOoChqJqnQqBK8
utG8fyKXy3505bo/5N3v
=2Ir7
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
