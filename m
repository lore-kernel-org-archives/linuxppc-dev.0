Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5F5342C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Nov 2013 02:46:21 +1100 (EST)
Date: Fri, 8 Nov 2013 15:45:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131108154532.GO2493@sirena.org.uk>
References: <cover.1383910029.git.b42378@freescale.com>
 <1045921af1119333da2d14628473a20ed7a202bd.1383910029.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JIgDBBEDRU2Tt5Ar"
In-Reply-To: <1045921af1119333da2d14628473a20ed7a202bd.1383910029.git.b42378@freescale.com>
Subject: Re: [PATCH v5 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 vinod.koul@intel.com, s.hauer@pengutronix.de, swarren@wwwdotorg.org,
 timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JIgDBBEDRU2Tt5Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 07:32:53PM +0800, Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Acked-by: Mark Brown <broonie@linaro.org>

--JIgDBBEDRU2Tt5Ar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfQcYAAoJELSic+t+oim9B5MQAI2hUJqc2K2G9SSoRLNfYlqF
s1znFLKOQ1cTecd5jwJj/Akt19icp1fcEwwQi/mOGZxhAoKUic6tMuzDDfRKbxZB
eccwytknKUWQncezIZz6u384W49bBABPTKCmAkKSJHstzXiVVxSWeRgMTvRVkGEC
kjKLQQDON30zmLcT/8mEtEt6nT0vT3dimRXIHEiBi31SK1kBynYqDDd67SuICKPB
YLsRY6f7cpw5+Bs3Pk+HHIdnMtMMl3gj51Hr0xO9THGJu3PoLIqW24mCvV2qXK4U
zALThl+fgQRJ+PN9Oz/lXUE4gDgLNLKMDVXKe//8upl52Q7B27APZcSZG22IlYDb
Qvg+JgMunRpZaHQGd1/cA/lgFSF8dBYcbysWao9xqf+IPzrW6o8HELrwIWFO+og/
a20Jekpn6WFpsVJSLxOrUORDN/IfmlyCu18YQHAC7uYKDGNgLjVa7wGVVXk6XyF1
BCw+EBPF7+t2H3oobFwcR5gaD1+omJ7A2FB9gdK1I+zSDeaz7edSqbWFnEMzvdTx
Ynlpf6PR04g+UvHQr+Kn5RxofSKLJPdD1sumQPvArfw+fdKeKUUCSMAtH72BupvV
g/HqT99wyMcQiPyWPToDe3M1iNABmi7jHWyUEv8C/AcoZn4IdLJQ4Hnfh3EKXK/8
NRwu3wOKk0FhDaJwhzG0
=eddQ
-----END PGP SIGNATURE-----

--JIgDBBEDRU2Tt5Ar--
