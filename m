Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DD8FF2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 21:42:39 +1100 (EST)
Date: Wed, 4 Dec 2013 10:42:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131204104230.GD29268@sirena.org.uk>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
 <20131204072702.GE8609@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
In-Reply-To: <20131204072702.GE8609@MrMyself>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Implement symmetric_channels
 and symmetric_samplebits
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 03:27:03PM +0800, Nicolin Chen wrote:

> Sir, shall we also implement these two to other drivers like codecs?
> I know this symmetry is a new feature and might be still immature.
> By implementing it might bring some side effects. But meanwhile, it
> would also allows us to engage more people to test it, although myself
> have done a branch of tests with different user cases on my platform.

> Or we just wait for people engaging by themselves?

It makes sense to roll it out, since it's in the core if there is a
problem we only need to fix it in one place to fix all the users which
makes life easier.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnwcTAAoJELSic+t+oim9Xy4QAIWP6FbvgVh8Utw+PUNowHOp
NELcvB32ZsJfyos1dDs7IZfrnzvUW9lXcecTcx8PnPn0dryL08SkVV96ezalsPH5
DbcV8aAPKdRc3vYSKZAXB7W8b6sRgvLkOVJPS8Kqi7B6d0WcvWPfoE0Pn/J1sbxs
p9sIKE5Q6UwHcmxgKRo/PinZnTxot36bGSVFglxXpEcwIR4EBv/TxURMgDX0FV6P
kvlZrcOJti29WYsaSw/V9JHvIeRKnmQIKnZY+xN8ucxSpb2dmm3oeHwof/ci8BUi
iXPmMuhJnwcjH3OdiL19pwr1HHq311SHOFFsmmOTqGYX8BUTdjQSLgHVk/OdvV0w
QnLDfuK4LXqrA0ki5vqzw0ME4JU7vxRl2y/lG+QpQqSzIOXuuwy65aJ+MfiyD76g
HEZyvjcvacVhsuKOfnpe9MKU7CxxkkOIcb2IZI+S0K9jfBEjRA0brFX/hqMJLhke
PRkk6Leee5KfV9PmGIR9k2sQlqfbqxaF42HGwREpha5UOQAg+fm9oWgXt6Brk99X
LaVBIOX/cTZfhMqlfTWO5qwY58A72QzqNm8dJBqUKx05XtAEZJ2j0y12+N6Lu2vc
SW3o6ORBCckXGA5A8KywEzoca7eC1rcMxK1j/3VpS0aR+fN336HZyyWWDup3cKqO
XvZ9aGF4a1xNFpDmcpV0
=ufv+
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
