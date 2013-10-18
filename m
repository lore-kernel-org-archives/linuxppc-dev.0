Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 371DA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:34:07 +1100 (EST)
Date: Fri, 18 Oct 2013 18:33:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Message-ID: <20131018173331.GV2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9ss1VCek+7fjM2m0"
In-Reply-To: <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
Subject: Re: [PATCHv1 6/8] ASoC: fsl: add SGT15000 based audio machine driver.
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com,
 linux-arm-kernel@lists.infradead.org, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, oskar@scara.com,
 fabio.estevam@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9ss1VCek+7fjM2m0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:15PM +0800, Xiubo Li wrote:

> +	ret = snd_soc_register_card(&fsl_sgt1500_card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register soc sound card failed :%d\n",
> +				ret);
> +		return ret;
> +	}

Use the newly added devm_snd_soc_register_card() (in -next).

--9ss1VCek+7fjM2m0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYXDnAAoJELSic+t+oim9seMP/iiRnKDJNKcdrKFo60VsGo6M
qYoKvXuXS66QMJudg2iouuG9XhS3AklWnXhubsPCuUVddbmtGTUsliubs30YvXdo
0R6AAG3svmUvWfS776GCFpW8runhD4nmJNrPslOQ2TNRjdYNmI8PDyyykeeoD2SX
RfN2ZTWqrYgipBg/FXHgGNomYpCjnwmPh0onpXIi2A1LKEy1D65Np3aLgCBkXmqb
CXfoIUGc2t4FIHDXfwQ3PRCVmJ4mVsPb9ggylHPeZiHmIKUfSNVPAJn1pUA2SNKc
ZbdbsfxOVavbvYI3XYAVKyW3adjqNiOrYy/XhKcJvfEqD+Vgsv9JQyVM1YOenk/H
PaKBeoe9cmGJzU6lvmRLoXynZ82PrtGCuSM5mwZaM06rSgTkuRteJU6tctIugOdK
B2PtkCV14bpodixBuidOuSDyAewE2q+yLCDZIDSNju9n4M2tXacpnfSwMbRm/Cnv
9Np2xWsNXro1IwuYY4MzZwU+DAx4cF0nfzHfwmuRZUvvS14ujkcaRWrsoOCisDch
612ktvxCKAmzmNdkgaUi038QMqczxkfClpnHn3IDI0nxvdn4k1btF0WlVBbyo9zl
cuWEpjMpY/fPV94tXyj2m4LDz7bZf/tyZY8W/rD9hoeEXDJL83wNVpQPM72OcX6g
lSxz5AGiHxYtQqJS+PEJ
=+/EO
-----END PGP SIGNATURE-----

--9ss1VCek+7fjM2m0--
