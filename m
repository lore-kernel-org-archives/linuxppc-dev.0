Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1358A14008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 23:07:28 +1100 (EST)
Date: Tue, 1 Apr 2014 13:07:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140401120715.GR2269@sirena.org.uk>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NEvmWj2iiHf6S+l1"
In-Reply-To: <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts
 for Tx and Rx streams
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NEvmWj2iiHf6S+l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2014 at 11:17:07AM +0800, Nicolin Chen wrote:
> We only enable one side interrupt for each stream since over/underrun
> on the opposite stream would be resulted from what we previously did,
> enabling TERE but remaining FRDE disabled, even though the xrun on the
> opposite direction will not break the current stream.

This still doesn't apply against fsl-sai (nor for-next).

--NEvmWj2iiHf6S+l1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqvwAAoJELSic+t+oim9GMcP/3LAarX8wNmsxBGziZnwQuov
ObyHFjDnn4V5jsOMDr+9cUocgSSkcUx+pHI3lWeQgeogt0b9gan1RIN8V8Sbp0Sw
fN8I9SDvGZzyQQeqDCMwoLneZnN3rJ8d+SEXjIx88FdccGe5xM++1xflmtrTjan7
JwhXXY3WptxiKmwN7/SIUQkplxQeccJ0r0nhOrkz+vQuLO6dip04MZ0MYsH8oS+8
3/HZL5/DhyT77TP/BF2Qy046fSHN2Uv7XdEx5nIEcGewLFSBlhdHrdBgWyNMyw5/
ye9Zb/fNyEnaEUeOg+5LzwZsWjeDweY6BJBbRxi7sqdUd+aac5D2iIQGaOgonH4Z
JYpDJnwNNwoj9jSPufYILPIXO7lHRjB8mZfVOn28Bfgg1OrIGUo6R1U8HcThZ+i+
zs9K/koZ08bRtHm2YFNddppuH1iqty6IR/5IJ/M9czjYVdebqEZwXGdN23xQnagM
4U++uwI34DILJHmesHTyZj5RpJH+uR8F4u8gIVFKw9EAPKAKsD+SXfRrT6+Cu4hC
8lGuPTWjFtE/MMD9p/buwO9JYXCEhvHC/Xz96kp/w3VGCgm6V0V1oTkwO2MjpFnx
t8Vq0ucO1cIT82t2yXxPcFV1jbPTlY0KqHqcX0UEQqgCfmMypCvZqkNyLQfuQbd3
/b6i/r/Ufsy/6LDn2IOd
=mNci
-----END PGP SIGNATURE-----

--NEvmWj2iiHf6S+l1--
