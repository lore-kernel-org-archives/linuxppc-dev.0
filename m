Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x89NL697pzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 21:25:38 +1000 (AEST)
Date: Fri, 14 Jul 2017 12:25:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20170714112511.nhcgu2ogpufgele5@sirena.org.uk>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
 <20170714110233.fqkmgy7kyhje7mfy@sirena.org.uk>
 <1500030501.4457.70.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3trzf5fbgnvyazpu"
In-Reply-To: <1500030501.4457.70.camel@perches.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3trzf5fbgnvyazpu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2017 at 04:08:21AM -0700, Joe Perches wrote:
> On Fri, 2017-07-14 at 12:02 +0100, Mark Brown wrote:
> > On Thu, Jul 13, 2017 at 11:18:11AM -0700, Joe Perches wrote:

> > > I don't it's better.
> > > It's not that confusing if the 0/n patch cover letter is cc'd
> > > to all the appropriate mailing lists and all the [1..n]/n
> > > patches are sent with in-reply-to of the cover letter and
> > > send to the maintainers and appropriate mailing lists.

> > With large serieses like Gustavo is sending the CC list can easily hit
> > the points where mailing lists start blocking it, and the individual
> > pathces really do need to go to the relevant people so they have sight
> > of them.

> I agree and that's what I wrote.

The set of people who should have sight of the patches is wider than
just the maintainers.

--3trzf5fbgnvyazpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlloqhYACgkQJNaLcl1U
h9AYhAf/bzZk180+uonV/eWMvBLhp9DjDorYUwNH8iMEnK+C7PCG8uirPRHKbf2v
sRoRs1rR7Cit/xEc3dmfiKD+HbxZjqNGRG5D7Ba3qDIbwisF8m3XPYDXIN4OR7TH
f07aVu37OezSq/kQvTvkNzvImbCOvx2BzLPOH1/4KondYjMXy855MsLZurow4PxP
zcPf+5hUwWA/f4Q+u1VlMFzuseHX0t7c5V1QqD8SEfuPVWzr8Aj1W2GP8+DDD3PV
rBX4VdsTIeet8r6/xBY4xR9DeyLsfecwrupwVyY1W9A/wDSydfxfhuOlOAsqG6oo
RrGy5J1oGEfDD05B8o9cU8PElsWdHw==
=rvsf
-----END PGP SIGNATURE-----

--3trzf5fbgnvyazpu--
