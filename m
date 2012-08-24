Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CF7F2C01CC
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 18:44:34 +1000 (EST)
Date: Fri, 24 Aug 2012 10:44:25 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: dts: 52xx: drop critical IRQ from dts files
Message-ID: <20120824084425.GA12630@pengutronix.de>
References: <1345735866-10001-1-git-send-email-w.sang@pengutronix.de>
 <CACxGe6si6a6=9511e0W_YDsQTUr98KOkqTpzYJryakcAAqQvew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <CACxGe6si6a6=9511e0W_YDsQTUr98KOkqTpzYJryakcAAqQvew@mail.gmail.com>
Cc: John Bonesio <bones@secretlab.ca>, linuxppc-dev@ozlabs.org,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 04:59:26PM +0100, Grant Likely wrote:
> On Thu, Aug 23, 2012 at 4:31 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > The wakeup-gpios have been assigned a critical IRQ in current
> > devicetrees. The PIC driver does not support critical IRQs, though, whi=
ch
> > leads to the following error when booting (a PCM030 in this case):
> >
> >         mpc52xx_irqhost_map: invalid irq: virq=3D16, l1=3D0, l2=3D3
> >         irq: irq-16=3D=3D>hwirq-0x3 mapping failed: -22
> >         [WARNing skipped]
> >
> > Remove these entries until they are supported, if ever.
>=20
> The warning is a bug since the irq specifier is valid. Removing the
> irqs from the .dts files isn't the solution.

Adding another warning (not error) that critical IRQ are not supported
is?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlA3PukACgkQD27XaX1/VRvNzQCfaepoyap0rROFmzbgvsaui8fD
qcYAoKUXObX8kd2Fok8MUqF5QlV6Q6BJ
=ER8d
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
