Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D71552C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:50:07 +1100 (EST)
Date: Fri, 19 Oct 2012 13:44:16 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
Message-ID: <20121019104416.GH11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
 <20121019103039.GF11191@arwen.pp.htv.fi>
 <1350643608.3709.78.camel@mars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
In-Reply-To: <1350643608.3709.78.camel@mars>
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

--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2012 at 12:46:48PM +0200, Christoph Fritz wrote:
> On Fri, 2012-10-19 at 13:30 +0300, Felipe Balbi wrote:
> > On Fri, Oct 19, 2012 at 12:24:43PM +0200, Christoph Fritz wrote:
> > > USB controller may access a wrong address for the dTD (endpoint trans=
fer
> > > descriptor) and then hang. This happens a lot when doing tests with
> > > g_ether module and iperf, a tool for measuring maximum TCP and UDP
> > > bandwidth.
> > >=20
> > > This hardware bug is explained in detail by errata number 2858 for i.=
MX23:
> > > http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
> > >=20
> > > All (?) SOCs with an IP from chipidea suffer from this problem.
> > > mv_udc_core fixes this bug by commit daec765.  There still may be
> > > unfixed drivers.
> >=20
> > why aren't you using that driver instead ? Is it really necessary to
> > keep this driver around ? I would really like to see uniformization
> > towards that, if you use the same IP, then the same driver ought to
> > suffice.
> >=20
> > What's the reason for not using drivers/usb/chipidea ?
> >=20
>=20
> I thought about this too but wasn't able to use chipidea with
> MXC_EHCI_INTERNAL_PHY as it's called in fsl_udc.

that's a matter of writing the PHY driver, right ;-) It has nothing to
do with chipidea, actually :-)

--=20
balbi

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgS8AAAoJEIaOsuA1yqREqqsP/RCEO5N3cSYg+9eHqekUUlaO
NGDDLZzU0XeCtEaLw+pA3vP7iw+TpUfuu90FD4kH3QLDEWAdQbLZyps4wXBwa0/y
2mmYW/phMKBVhaBlDefles+ddHuIVktOkZC9YhcfDAeGtQoODq/Zv9n4Q2Am9/l+
HH+7M0U3FqLIbjKeyATjqEDvdGMpKhscPemNjicRTcww5VZOp3VBA11Fofif4KK7
IjsYPOXBJsKMuBeQnUD5RhLtCQwSi3m7U5e5sw5yvxdEYc0XTOu6ttllVMNbTIIM
fUbFBX65fkBh9ojYGyu+lzawWPh7CrI8SrvQoo5t8L3lek64pcVecQwgwlWSetMW
Yo7Qk50RXzBJSj9Tb49CegMZQUH9dVvKNN0m5C2Sdg6zfN87MzYZPEvCD5KQbZhO
+5OwQV9+mOOnqIcST8uiZEd934SObaE0VQCryE0I4mMBURp0P2pPaxLKsc4l9cMz
cQ1XQFJlAEF9iOZ6Dn1uZ8zuthE4rB5kIcAOZyB3DkXpVzW59gtBhhb0SBF6GP7e
iDohYyBN4EBom9xCzYkVV8gWvw6FjSWt2UfZS8OxoC6SE4DlUpCbzhe+bjsa5Ehv
OJniHp8QgOTQiJ3MBRmi5uO9myoBBKMYCkqtaRrLdJ2u2cbim7YUwDAxptFrvzt+
T26hmlOSOfxD4rCNN1bp
=oEiE
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
