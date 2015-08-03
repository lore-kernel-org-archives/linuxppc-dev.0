Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D86E1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 02:22:14 +1000 (AEST)
Date: Mon, 3 Aug 2015 17:21:47 +0100
From: Mark Brown <broonie@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Markus Pargmann <mpa@pengutronix.de>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Message-ID: <20150803162147.GB20873@sirena.org.uk>
References: <55BA364E.1000803@maciej.szmigiero.name>
 <20150731055843.GX30895@pengutronix.de>
 <55BB9082.4030206@maciej.szmigiero.name>
 <20150802185103.GD19600@pengutronix.de>
 <55BE9D3B.3090303@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nuX4E7Vid9I2gnPU"
In-Reply-To: <55BE9D3B.3090303@maciej.szmigiero.name>
Subject: Re: [PATCH 6/6 v2] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nuX4E7Vid9I2gnPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2015 at 12:44:11AM +0200, Maciej S. Szmigiero wrote:
> Adjust set DAI format function in fsl_ssi driver
> so it doesn't fail and clears RXDIR in AC'97 mode.
>=20
> Changes from v1: fix indentation to be consistent with rest
> of the driver.

Inter version changelogs go after the --- as covered in
SubmittingPatches.

>=20
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

Please don't bury new patches in reply to old submissions, especially
not individual patches - it makes it hard to work out what's going on
and make sure that the most current version of everything is being
applied.  In order to avoid confusion I'm not going to look at these,
please resubmit as a new thread.

Please also try to thread your patch series together (git send-email can
do this for you) - it also helps people keep track of things.

--nuX4E7Vid9I2gnPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVv5UaAAoJECTWi3JdVIfQ1tAH/3GpZyz84n9TBXOTdPeduQ3O
ka18YZj95knMS6DPi8S99VkHKX7izp3y6Zd9jEngoanwK44atN23dx4s9z41zGRs
q9wofC4FJ+ADT7Gm2WWzn2ohb/dusCYm43r5jCM+RjltQJib2AgQm2VF/picdGtk
TIK0eL+TAbq/1PfdhaP5EBWIZLX5tYa56e7W9JnZfvmgx/HgYaDtwi7+SG900tTF
mQFrNuxReZ0rSQqiYs9i4CnP3QMDzaRPScd17kerciLfLroOMlcH3Co30O1rAnzv
i4HnW7qEUlNfMJLe9Ovpsy31af7DR5+GMByyEhMHvUR59q5OhTQrXYZ2pQPzHfI=
=IlXQ
-----END PGP SIGNATURE-----

--nuX4E7Vid9I2gnPU--
