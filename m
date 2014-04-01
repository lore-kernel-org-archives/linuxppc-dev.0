Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49CE1140088
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 22:57:15 +1100 (EST)
Date: Tue, 1 Apr 2014 12:56:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140401115659.GQ2269@sirena.org.uk>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-2-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HcsbBFLnFtTJqgUw"
In-Reply-To: <1396322227-482-2-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH bisect 1/2] ASoC: fsl_sai: Fix buggy configurations in
 trigger()
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


--HcsbBFLnFtTJqgUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2014 at 11:17:06AM +0800, Nicolin Chen wrote:
> The current trigger() has two crucial problems:
> 1) The DMA request enabling operations (FSL_SAI_CSR_FRDE) for Tx and Rx are
>    now totally exclusive: It would fail to run simultaneous Tx-Rx cases.
> 2) The TERE disabling operation depends on an incorrect condition -- active
>    reference count that only gets increased in snd_pcm_open() and decreased
>    in snd_pcm_close(): The TERE would never get cleared.

Applied, thanks.

--HcsbBFLnFtTJqgUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOqmIAAoJELSic+t+oim946MP/iXSUpw+dx2A7yXMkq/swc7Z
D7A0Nr0YZjM7MvTjo+rbtHCPXCSbST9P0SUEKMJUc8dRzqklAJNJ5um/gUpY+4le
DtalVp3+h8R+kgY92sOoK2Qh0kN29UEo+MUf1E0fS1f5/xQi/uGDmmCWEdjbjeNB
ENCM6ByrtI4vuiV051Wj9UQcSU2ppdJiDE/ijCuNQjeb8aE0U0Brznx7f1mX4m0Z
b4zhhsCIwQiDxA7BWtBjTy8YDiEGtMNYZkeMYMtNgElwYmISsPnXoQ9I806Whm2f
hqONkJSBrQY6cfsXbJqkcLTpP/FaWq56Dr3oPFCsudI3U7FOyUACGnJjGMF8k2Xq
WfzHhW4aMQRSLoCzUmS4Lch7Y0AqXenMz0ikW5mqh1ZuHHCwh1w+4Xnr/mr55D6/
OHGTa+uveC/KiRFPun9tahi3d572GMJg0uBd5LBUgOBOLKp7EBFWKywOyoljQyKQ
DxMNLM+1TQDFJCYvEwnqCUcBRCyHtdNU0W0Ursqb/IT7z4V1rWxF4zFMC42BdFk9
s2w4hRqJk1wOQEOtydSwA97zlsTdSZPfoOeE4mQoWwmgNB198CfdUsR0UpEDx1+v
75nimuF/NgCSzy2Q8l3Co7XzU5z1YhSH32O3Vya8RQ2Fs4zT7x5I2HANR26nTLCW
eR2Rq4hHW7NRGPNwUwOZ
=KNUf
-----END PGP SIGNATURE-----

--HcsbBFLnFtTJqgUw--
