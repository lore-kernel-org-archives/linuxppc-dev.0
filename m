Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 425E62C0345
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 00:23:44 +1000 (EST)
Date: Fri, 12 Jul 2013 15:23:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Timur Tabi <timur@tabi.org>
Message-ID: <20130712142333.GG24508@sirena.org.uk>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712084328.GW24508@sirena.org.uk> <51DFF277.7020105@tabi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4B4+7MsODflw+h2f"
In-Reply-To: <51DFF277.7020105@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 shawn.guo@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4B4+7MsODflw+h2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 07:11:35AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> >Yes, that's why I just went ahead - you'd said recently that you'd be
> >out of action for a while and not able to test anything.

> Yeah, I'd rather you waited until I at least made sure it compiled.
> Is there any way you can at least install the Freescale PowerPC SDK
> and do compile tests?  At least that way you won't have to wait for
> me for every little thing.

Several of the automated systems that cover -next do PowerPC test builds
so I think it's getting covered already (Stephen Rothwell plus I think
that Fengguang's system has some too).  Now that I'm keeping everything
in topic branches it's much easier for me to discard anything found in
such testing.

But yes, it's easy enough for me to install a PowerPC toolchain - in
fact I was going to do that anyway as there's some SPI drivers that only
build for PowerPC which I want to clean up.

--4B4+7MsODflw+h2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR4BFcAAoJELSic+t+oim9G/EP/1WLROvhyhukAZNZ47Za9fKA
L2PlJEJwQMcS1MHxyAx8Y6PAXkBCCXBnBhQi0U6I1TS9aHzJAcuwV9cb4XypDLDm
bCNdcYriejymY374I0n1/DZys/uaM5KJPMCDPC4u5XqT9mWIHQ5Znc21V1u98dk7
JAiha/uE5ichnQtNiS8Twi7Qg5HdkY3HpG5BzyJVJzjZ5X2hdSKJZ/m/62XQnko6
t2gBaS7VuBQad3wVZ/cqkINqaSBdXRBqd+HvL9GkC67Vl8TeTQ5x6o/o5IpgsLYu
GMLQWORNIJ0EHvJP2yEIRql6+dhVshSlc0yVoBjFTiC/5ZSYNigEU0Jt4oS+7OIW
iWZQP6uiSK6jhotCt3Te2YT4ZM/q4l3r6lSFFvXd8lvvYWFD8h3x8fPUyd9taqRt
YLcFhEP9HKfFYhEPff0mg4BCl5FsldM583nOMDzlUpTUuWh3pDfY+9koCRk01YVn
ZVBkPzHyskIwyKpzxao5CvnE73ie+tbS50E+rbfFku9T47iGLJc0lTCH2y66hfus
v28lTgNSsnN6L8Uz6zMXJorq7bNVot0aOWPMUlVpQ69Bav8JCwvtagZhAMmJQave
nmhtuojK/12eVl8xfpACI4cxHDIHnf6URU/TCiA6AX1nM3ZnJd+yiGgttG3LW/qD
UKmDqaB8P9IekG1DJtvE
=wJWv
-----END PGP SIGNATURE-----

--4B4+7MsODflw+h2f--
