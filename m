Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 411A0B7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 07:46:15 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 67B10DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 07:46:14 +1000 (EST)
Date: Sun, 14 Jun 2009 23:46:03 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
Message-ID: <20090614214603.GA24323@pengutronix.de>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<20090614122136.GD3639@local>
	<20090614171406.GA1010@pengutronix.de>
	<20090614183357.GE3639@local>
	<20090614190533.GA7387@pengutronix.de>
	<20090614192707.GA11003@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <20090614192707.GA11003@suse.de>
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2009 at 12:27:07PM -0700, Greg KH wrote:
> On Sun, Jun 14, 2009 at 09:05:33PM +0200, Wolfram Sang wrote:
> > Well, I assume that issues regarding checkpatch do not have the highest
> > priority (especially while the merge-window is open), which is understa=
ndable.
>=20
> Hm, the "merge-window" for new stuff like these patches is pretty much
> already closed, as you didn't send them _before_ the merge window opened
> up.  You need to get them to us sooner, so we can test stuff out in the
> -next tree for a while before we can merge them.

Seems you got me wrong here :)

As I stated in the introduction ("PATCH [0/2]"), this patch series is _not_
meant for the current merge-window. I just happened to be done with it now.

With the above sentence I just wanted to give a hint, why there was not a r=
eply
to my checkpatch-mail (as Hans seemed to be concerned about that there was
none).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko1b5sACgkQD27XaX1/VRuqTgCcDl737+mbnMLDUbfJehUaRXeR
rOMAn0rMkD4TsDyT8vcs+jx95DnP7yx9
=jvq6
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
