Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dorchain.net", Issuer "Dorchain Family" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C69A3685AC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2005 04:41:17 +1000 (EST)
Date: Mon, 17 Oct 2005 20:34:43 +0200
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051017183443.GB28756@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
	<1129327105.21765.39.camel@gaston>
	<20051016081759.GA2609@Redstar.dorchain.net>
	<1129452167.7620.34.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
In-Reply-To: <1129452167.7620.34.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 16, 2005 at 06:42:46PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2005-10-16 at 10:17 +0200, Joerg Dorchain wrote:
> > On Sat, Oct 15, 2005 at 07:58:25AM +1000, Benjamin Herrenschmidt wrote:
> > >=20
> > > This looks like a bug that was introduced by linus in 2.6.13 and that=
 I
> > > _think_ should be fixed in the stable series, so if you get 2.6.13.x =
(x
> > > =3D latest stable release) it should work.
> >=20
> > 2.6.13.4 does not fix it and(, as far as I skimmed it,) contains no
> > changes to the ati framebuffer code.
>=20
> Hrm... annoying, I was sure it was fixed, I'll have to check. The bug
> isn't actually in the ATI code, but in the PCI code. Well, maybe you are
> hitting something else...

It seems.
>=20
> The bug I'm thinking about was fixed by git commit
> 6821eb3b64158ec230982f4db5f027b326edd620, here's the patch. Let me know
> if it helps.

This patch is contained in 2.6.13.4. It did not help.

I selected

CONFIG_FB
CONFIG_FB_RADEON
CONFIG_FB_RADEON_I2C
CONFIG_BACKLIGHT_LCD_SUPPORT
FRAMEBUFFER_CONSOLE

The 2.6.12 version worked. Would it make sense to post the complete
=2Econfig?

Bye,

Joerg


--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDU+7DjY4+4PdzvOARAuu+AJ9AVOyAeDn0NfALitj2l2Q5TgmIlgCfUnl7
W6tnpL3woRdFrPjavxEFUNw=
=V4K2
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
