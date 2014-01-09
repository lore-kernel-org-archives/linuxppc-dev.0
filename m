Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1896D2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 04:26:34 +1100 (EST)
Date: Thu, 9 Jan 2014 17:26:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Message-ID: <20140109172616.GE12858@sirena.org.uk>
References: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
In-Reply-To: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl-ssi: Add missing clk_disable_unprepare()
 on error in fsl_ssi_probe()
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, perex@perex.cz, yongjun_wei@trendmicro.com.cn,
 robh+dt@kernel.org, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 10:27:31PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing clk_disable_unprepare() before return from
> fsl_ssi_probe() in the request irq error handling case.

Applied, thanks.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSztu1AAoJELSic+t+oim9SboP/2N382yLVNGVIHJpJOstw04+
CYdHYXBLq8W1jBEklDhyppTm5fXSYymPeWrgL7T5cBnF19ODkxvxHrSKal73Bus5
zkk5uuo5ahn3YDsd1/a2OuhWDfD4Xya2/g8osgRaUvjbZbfanFpA+1N0kbNVgq7O
w1uvF4VtuHs2BwYDX3I3KU7UGg7e8z37aw2XqhWk05wdYousZLI4+5JJ4c+giKI3
sfJtyyIib0iSi5oZnIH3leoq9RsTDZS1E3uJvmtWUo5oboUtox0ZHAcEptgc/Icq
q6MjiUdjtETDGHRCTqX3r8NAMpVQm9fq5bCydBy9f3CRrRorRapATA/jvN2J6tGo
ZdxIGvwlnQETa3E/8MlrDQ8dUeEtk/xZmum6fVtDCp7FfQRHoMe+AkWGED99pdY8
GaY2MdlY6iL5ljHwltUlyCbaHb1wa63Xq7XrocSueJKwWKjCnx+zgYZhjoikIfdR
h7nMyTshUZhb/Et57a8jdTHtl3JNpT+MT8EO5d8Ly9oTAk3DsQKbOCUsZNQM6glz
f0j9SbsH+gU8tKqPYnQD2xYMU65otncEY83Lqctrls6Q7OU4NKeoNSRjmb45xYfV
11ZmHmBXkFOy6+Rayii7iH+9KpO7LQ3MCtv4eZ73TrGa3/IeCKIJpqcIihENZYXq
nAZsMLbu1ceVAJM43ZtC
=jglI
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
