Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BBB0B7CE4
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 19:55:13 +1100 (EST)
Date: Mon, 22 Mar 2010 09:54:29 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] device_attributes: add sysfs_attr_init() for dynamic
	attributes
Message-ID: <20100322085429.GA15063@pengutronix.de>
References: <1269238878-991-1-git-send-email-w.sang@pengutronix.de>
	<20100322064027.GG31621@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <20100322064027.GG31621@core.coreip.homeip.net>
Cc: platform-driver-x86@vger.kernel.org, Greg KH <gregkh@suse.de>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@infradead.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sujith Thomas <sujith.thomas@intel.com>,
	linux-media@vger.kernel.org, Mike Isely <isely@pobox.com>,
	Matthew Garrett <mjg@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 21, 2010 at 11:40:28PM -0700, Dmitry Torokhov wrote:

> My standard question - are all of these need to be dynamically
> allocated?

I have my doubts for a few of them. Still, this would be a more intrusive
change than just fixing the BUG appearance, so I'd like to leave that task =
for
those having the proper setup. Regarding thermal_sys.c, which has two bug
reports already, it needs to be dynamic as the attribute name depends on the
device.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkunMEUACgkQD27XaX1/VRsGjQCgteCT6utOHw1aT5jKNRJnqWa2
uqIAn0gXBpowL23wFc6gSgABp3M5T/oZ
=eDuH
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
