Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2DBF3140120
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 06:40:01 +1100 (EST)
Date: Wed, 2 Apr 2014 20:39:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhao Qiang <B45475@freescale.com>
Message-ID: <20140402193945.GH14763@sirena.org.uk>
References: <1396343450-6199-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
In-Reply-To: <1396343450-6199-1-git-send-email-B45475@freescale.com>
Subject: Re: [PATCH v2] spi: add "spi-lsb-first" to devicetree
Cc: B07421@freescale.com, baruch@tkos.co.il, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 wangyuhang2014@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2014 at 05:10:50PM +0800, Zhao Qiang wrote:
> add optional property devicetree for SPI slave nodes
> into devicetree so that LSB mode can be enabled by devicetree.

Applied, thanks.

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPGd+AAoJELSic+t+oim9AS0QAIpuDugLQoc6QM4BDNSTaSQQ
xrJO1C8WdLdU9raGKErnFdIGwiuuEeqXGsRzB1Quq27xq2eRgt5RTHICBwkNIL0r
ASXF494at1tapvoO7Z4jjaW+tsDpH3o1ZFgWBcD9JfVPvY8KnJWYaY+MzJaXXd0f
cL7qKP3yQ21/OS8WDgouPCkjRHV8R3a3bPD4286JL46gboNszPaRWuFAMaaF93Ul
KBTRGZAAELZBcXdfZqfD5D1cow9FYZFSQLgRADxI/WSgPbstOfbJuI3HmFd0HFgr
AhZY+j6i4qTchoQGklpMXfGQLPq+eC+VHVdK88axJqONUMPPBDbv8LLTk21ET/ce
US2P5HdxWDKLxQY0Fh/nBMtjrmVYpP7YzfmmpiyL6aZqy1EAw5hvM6h+Fcw+VT/y
nWcMaOKRHhMc7wOH5CyLndvK63LXpLUtbW8WOSqywm4wCTpGRMmviW24y0E/XaB1
MhStyJ1iRVdBDMFsEZlmRB3+WnUZ5EftKnlImox9o4oZB7oPCuAJnz80Ca3PJcwf
XccsRs/nNOjnwagZe+9CZzg5KWwlkKoTZmTnRxmYJ6GRrLFG4SkbJcTRtjlljrEn
t0qeyjEc3cU8bO4NGLCdnu5abt+nc+Jr1kSXFY4UwhJQZ6Nqi4WC5XI+bmYbTMct
enNvk2w/EqJcnK3B8cru
=13uQ
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
