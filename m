Return-Path: <thierry.reding@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7vVP0BY7zDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 22:58:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so863093pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 05:58:52 -0700 (PDT)
Date: Tue, 9 Aug 2016 14:58:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
 Ludovic Desroches <ludovic.desroches@atmel.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Florian Fainelli <f.fainelli@gmail.com>,
 Sonic Zhang <sonic.zhang@analog.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Jochen Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>,
 Joachim Eastwood <manabian@gmail.com>, Carlo Caione <carlo@caione.org>,
 Alessandro Rubini <rubini@unipv.it>,
 Linus Walleij <linus.walleij@linaro.org>,
 Peter Korsgaard <jacmet@sunsite.dk>,
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Barry Song <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Alexandre Courbot <gnurou@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@stlinux.com,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Message-ID: <20160809125846.GA17535@ulmo.ba.sec>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 01:36:17PM +0200, Wolfram Sang wrote:
[...]
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index b126dbaa47e370..d9979da11485ae 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -932,10 +932,8 @@ static int tegra_i2c_probe(struct platform_device *p=
dev)
>  	i2c_dev->adapter.dev.of_node =3D pdev->dev.of_node;
> =20
>  	ret =3D i2c_add_numbered_adapter(&i2c_dev->adapter);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add I2C adapter\n");
> +	if (ret)
>  		goto disable_div_clk;
> -	}
> =20
>  	return 0;
> =20

Acked-by: Thierry Reding <treding@nvidia.com>

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXqdOEAAoJEN0jrNd/PrOhSNIP/RQ75Esfs8mPoEh7M/5DOHO2
+MZA5wZFAjAq9Fs0Fa9an7cdEdBzl08eV9pTSMbIPFnWbsUJEdxslWL3DSzEo4C4
unceavytjzf22ZcNmqumed4culNlRrXlTXFIUkm0h+tV2ihE9WcSuIGQKzlvukxy
3RK+D1sqgBwfdU12IUnTkcd0wVY2nn0+6anihxSHX5GiEmt/a8hpYE47C/aRs+IE
HIljoV10JSV5iDufUnxxvvnqXo/yG0F/8kPz3lD/zdMaBFvHmcJntUiEWf/6vHd2
rqz+6KeEX8fHuPsfGy8HQx/LceZRGVo6bQX5i1DH6DBoq4UVbzgPe4At6h4pQpCh
W1EXyM8D98tVsXK0zb5L7+nPPdid+d8hulME8184DA0DXS3okVKV5sP2NPkRFKiG
/1eHD6rmyBweZcfMJv/kkJc5OFEzoe0fVeIpq/+c1BdkSBBLQEDAeAAE99diFgMz
nETfb+IqVqjknOh37oEgw66bo1Xgv3lQWM4YxLEu5Y2FZXeQlAs5Z99NkXd0LnXT
e2IMgYn0a0qGU+mp7qjA4CCxqYoxtIByqr3B7bQmVRvIRXvQbVKRcZz2a1r/zhj7
Y0RSO9me3E8zF8LkaxoCPhkNNP2r5Bbufh3TOx42WCBCq1N0JyplaDSJRdOM6GjK
eLEXDPBaPNV2IKKCm1xm
=n1jF
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
