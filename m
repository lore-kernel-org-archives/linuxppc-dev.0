Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65E042C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 04:34:42 +1100 (EST)
Date: Thu, 9 Jan 2014 17:34:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140109173434.GG12858@sirena.org.uk>
References: <1389264168-13379-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
In-Reply-To: <1389264168-13379-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Set default slot number for common cases
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 festevam@gmail.com, timur@tabi.org, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 06:42:48PM +0800, Nicolin Chen wrote:
> For those platforms using DAI master mode like I2S, it's better to pre-set
> a default slot number so that there's no need for these common cases to set
> the slot number from its machine driver any more.

Applied, thanks - but note that this will mean anything that does want
non-default TDM will need to set it every single time it runs rather
than being able to do it once on init.  This might need revisiting if
there are users doing that.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzt2nAAoJELSic+t+oim9NU0P/3XfGECI6s/aDNI1DLXM17CY
sR3EIh88G2eOlthFPcWg3e6KP2eTE8Dp1BflkAFmPjuw/njOQEyDRA//37dQk5NT
oO731gFGisUjZJs+XyzsYqD1o/Uxtc/FPB0j22CWP50ljhbEo3whv+vK+OGW9V9P
yYkY1/w+Gwc4SUV0pdILPgHP0iTJcrOunesxsQpl7XtWqezqmWZ+HzqV4G367ysx
gp5bjl+oR+FjCClI3xN2Ig1wyz5sVntJzO8LWx8MoHQgbF9gPIN2XuGikAVc1I2g
7pkjcNYUxDxDqeXcyaw65IGbD2F2WIyu0odqXV9zjetPEtWcxoXhYJEivTFBgMwc
/S3b1JlLvQSjWsbtQfVFWweTEV17Oic12+VCHx/E4K81/0PTTxRVz6mCQjDUUa4C
6ZWP7uPtuXax2IOhwhDpCgnUfU5BmJdItLldsgvkVpNTeqa1p1s7tClX1ovKyAXk
kmuMWfvDiMgHv77nYTBy26sdocUTyu+5QeInBVQKh5NNygWo0emQk6V6T+fkdh0k
qXaLdpnaWEaHTLGN/38F3vjagGmtF9KDSqQPzFbw0giCV1HHxkodWBhQ4KNMdNpm
4+nMopqM95lKTGAmMB1OLMTSwRSxS+9OQ4N6h3X0nzFT+Nl1CUG+Do7a3EC/h5MF
7ejmCnsIoOT7gWTt/DT+
=N3wP
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
