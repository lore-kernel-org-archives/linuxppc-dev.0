Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9311A1A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 19:45:44 +1000 (EST)
Date: Thu, 7 Aug 2014 10:45:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140807094527.GC17528@sirena.org.uk>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Gpwijd/hIJ1U6yrH"
In-Reply-To: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Gpwijd/hIJ1U6yrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 03:32:05PM +0800, Nicolin Chen wrote:
> From: Nicolin Chen <Guangyu.Chen@freescale.com>
>=20
> SAI supports these operation modes:
> 1) asynchronous mode
>    Both Tx and Rx are set to be asynchronous.
> 2) synchronous mode (Rx sync with Tx)
>    Tx is set to be asynchronous, Rx is set to be synchronous.
> 3) synchronous mode (Tx sync with Rx)
>    Rx is set to be asynchronous, Tx is set to be synchronous.
> 4) synchronous mode (Tx/Rx sync with another SAI's Tx)
> 5) synchronous mode (Tx/Rx sync with another SAI's Rx)

This seems to conflict with something else on my branch - not checked
what.  Can you take a look please?

> +Note:
> +- If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
> +  default synchronous mode (sync Rx with Tx) will be used, which means b=
oth
> +  transimitter and receiver will send and receive data by following cloc=
ks
> +  of transimitter.
> +- fsl,sai-asynchronous will be ignored if fsl,sai-synchronous-rx propert=
y is
> +  already present.

Might be worth printing an error here.

--Gpwijd/hIJ1U6yrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT40q0AAoJELSic+t+oim9L/IP/09XmprJfNXyU1qqKlJhv70c
tj+U4iIPJlroeCqeOWfpG4qfqsJ8cGKkT7y9/c2+MFbh5aKn4yD8/WaG9gBzDZ6n
WwXLuD5c/yaAhWnlN2ekYOS7oG/Odzmb//BZNnPssxQW21hR8pqAT+KgUN6waslu
qlv7s/p1qqg67J/bEzHeh+D9VhCJooVdRvl843TDDZDUeaM/PyXOyJKpz8KawSs2
Txn5PKLh6UOOFSHQegZ7i84k8gjEwo0Rtl3edLtHjKUKGZf2azDrd4iffb9heiGH
OXb+N20qzFgCi6afkzx8B8fU4vvwd8tCGALe3kiStokVfYZvNG/2MB5MB7as+/7Z
XLpd1JCqJo3UXFBGS57RGH2jguIxla+0RJLbGMU4+4JCsHicUws3AqQl/yAtkgJs
2Xp++ABOQRum9jx/6q6LQfkegVzStr6KMC/aaIVUZCRFXRsdVpHMxqi/9hq7/7AB
ALG0R2J6qTCRTpCUNCmw6M+Xa0REODq4e6zZhyZy2UKrPwfYk1+f0HQfNTieCmmP
al8tU58vpKfMEjPSMcAA0SHb94VbBansfK8/43jm7itnVJYAZ6WNw5+nr/LmkmRz
gyh/7qrOeNml4NAs3CpPyrBgSP2CacH/LFpPEoDSytaPXbafUlisTtQBRDriYIRU
sO39I/WMNnI9lYcXI80e
=yhVo
-----END PGP SIGNATURE-----

--Gpwijd/hIJ1U6yrH--
