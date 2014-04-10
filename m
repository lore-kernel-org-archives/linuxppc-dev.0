Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 503F714009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 09:11:20 +1000 (EST)
Date: Thu, 10 Apr 2014 23:36:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140410223631.GG6518@sirena.org.uk>
References: <1397143575-10426-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jk/5KjyVsvxWSMIA"
In-Reply-To: <1397143575-10426-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v6] ASoC: fsl_sai: Add clock controls for SAI
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net,
 galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jk/5KjyVsvxWSMIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2014 at 11:26:15PM +0800, Nicolin Chen wrote:
> The SAI mainly has the following clocks:
>   bus clock
>     control and configure registers and to generate synchronous
>     interrupts and DMA requests.

Applied, thanks.

--jk/5KjyVsvxWSMIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRxzsAAoJELSic+t+oim9+5cP/R5cdpTumXrEfPAIM2WIo0sQ
gi/Fs1bR4L9HiEXNVOh7kueN4AzxE2Kn9ijRXX6J1R7VrD/vOMNzdai4AyYjJL0C
LEU5SW2ehlC8/u1s4HP/6/XGmU9AyJDJjsuq4MPj9AeXsqNHXFmvfST6arZO1q/Q
v18z7Tp+XKmR7/8to4+72AlctPXyKDTh0cZXkcayV7JUgbIsMNjn746Oo08umf2/
ahF3L/nNnf5+sYg7j0ZHl7tjkgHSpq8ZPcj+NA5HktwAMJX1kEGcxIDPa7gKP/n6
bSGGwmvEGlkeEWkb1ee4xsw46LQ++M+RtkDBc79FikTi/b8I+hw07yG4gtg8GYGS
4NNRu1/IzoEWwzggdOjzqqA4vHcfbrO8i62X+kLx72CMVnHBYXR+2gMlOAo1OCla
fJL6heywU3mqWXy6KLCBZ4Eb379GN3VXURamYc0FiYvlwFIz8554LAiT1SO4IFoa
vwKi05GMLAZpEtDNxTrD6N6sZv2hCIsv7xAO/gxBiQJMZU+Lni4wOHWAkpu1OvhL
bJsal3eH76R7JZ5F8e6/w3rabqHVSGaYjjERJIQGA7uMjoZkReHGDwStbmTUU4Yi
fgkRcq4XEovtZ8LuYz+WI8vpe99F/5ipXpilJpmJTpIsRNBZYLxubBHvPztp6v12
N//79nPMbYMsR+9Yiylm
=7bWg
-----END PGP SIGNATURE-----

--jk/5KjyVsvxWSMIA--
