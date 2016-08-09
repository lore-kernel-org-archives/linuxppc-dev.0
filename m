Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com
 (tuxdriver-1-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7wjq17NNzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 23:53:50 +1000 (AEST)
Date: Tue, 9 Aug 2016 08:55:22 -0400
From: Neil Horman <nhorman@tuxdriver.com>
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
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 Jochen Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
 Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Seth Heasley <seth.heasley@intel.com>,
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
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@stlinux.com,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Message-ID: <20160809125522.GA15676@hmsreliant.think-freely.org>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2016 at 01:36:17PM +0200, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-amd756.c         | 5 +----
>  drivers/i2c/busses/i2c-at91.c           | 2 --
>  drivers/i2c/busses/i2c-axxia.c          | 8 +-------
>  drivers/i2c/busses/i2c-bcm-iproc.c      | 8 +-------
>  drivers/i2c/busses/i2c-bcm-kona.c       | 4 +---
>  drivers/i2c/busses/i2c-bfin-twi.c       | 4 +---
>  drivers/i2c/busses/i2c-brcmstb.c        | 4 +---
>  drivers/i2c/busses/i2c-cadence.c        | 4 +---
>  drivers/i2c/busses/i2c-cpm.c            | 4 +---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 +---
>  drivers/i2c/busses/i2c-davinci.c        | 4 +---
>  drivers/i2c/busses/i2c-diolan-u2c.c     | 4 +---
>  drivers/i2c/busses/i2c-dln2.c           | 4 +---
>  drivers/i2c/busses/i2c-efm32.c          | 1 -
>  drivers/i2c/busses/i2c-exynos5.c        | 4 +---
>  drivers/i2c/busses/i2c-hix5hd2.c        | 4 +---
>  drivers/i2c/busses/i2c-i801.c           | 1 -
>  drivers/i2c/busses/i2c-ibm_iic.c        | 4 +---
>  drivers/i2c/busses/i2c-img-scb.c        | 4 +---
>  drivers/i2c/busses/i2c-imx.c            | 4 +---
>  drivers/i2c/busses/i2c-isch.c           | 4 +---
>  drivers/i2c/busses/i2c-ismt.c           | 4 +---
>  drivers/i2c/busses/i2c-jz4780.c         | 4 +---
>  drivers/i2c/busses/i2c-lpc2k.c          | 4 +---
>  drivers/i2c/busses/i2c-meson.c          | 1 -
>  drivers/i2c/busses/i2c-mpc.c            | 4 +---
>  drivers/i2c/busses/i2c-mt65xx.c         | 4 +---
>  drivers/i2c/busses/i2c-mxs.c            | 1 -
>  drivers/i2c/busses/i2c-nforce2.c        | 1 -
>  drivers/i2c/busses/i2c-nomadik.c        | 4 +---
>  drivers/i2c/busses/i2c-ocores.c         | 4 +---
>  drivers/i2c/busses/i2c-octeon.c         | 4 +---
>  drivers/i2c/busses/i2c-omap.c           | 4 +---
>  drivers/i2c/busses/i2c-piix4.c          | 1 -
>  drivers/i2c/busses/i2c-pmcmsp.c         | 4 +---
>  drivers/i2c/busses/i2c-pnx.c            | 4 +---
>  drivers/i2c/busses/i2c-puv3.c           | 5 +----
>  drivers/i2c/busses/i2c-pxa.c            | 4 +---
>  drivers/i2c/busses/i2c-rcar.c           | 4 +---
>  drivers/i2c/busses/i2c-riic.c           | 4 +---
>  drivers/i2c/busses/i2c-rk3x.c           | 4 +---
>  drivers/i2c/busses/i2c-s3c2410.c        | 1 -
>  drivers/i2c/busses/i2c-sh7760.c         | 4 +---
>  drivers/i2c/busses/i2c-sh_mobile.c      | 1 -
>  drivers/i2c/busses/i2c-sirf.c           | 4 +---
>  drivers/i2c/busses/i2c-st.c             | 4 +---
>  drivers/i2c/busses/i2c-stu300.c         | 5 +----
>  drivers/i2c/busses/i2c-tegra.c          | 4 +---
>  drivers/i2c/busses/i2c-uniphier-f.c     | 7 +------
>  drivers/i2c/busses/i2c-uniphier.c       | 7 +------
>  drivers/i2c/busses/i2c-wmt.c            | 4 +---
>  drivers/i2c/busses/i2c-xgene-slimpro.c  | 1 -
>  drivers/i2c/busses/i2c-xiic.c           | 1 -
>  drivers/i2c/busses/i2c-xlp9xx.c         | 4 +---
>  drivers/i2c/busses/i2c-xlr.c            | 4 +---
>  55 files changed, 44 insertions(+), 161 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
> index 6c7113d990f882..274908cd1fdeab 100644
> --- a/drivers/i2c/busses/i2c-amd756.c
> +++ b/drivers/i2c/busses/i2c-amd756.c
> @@ -378,11 +378,8 @@ static int amd756_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		 amd756_ioport);
>  
>  	error = i2c_add_adapter(&amd756_smbus);
> -	if (error) {
> -		dev_err(&pdev->dev,
> -			"Adapter registration failed, module not inserted\n");
> +	if (error)
>  		goto out_err;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index f23372669f770f..03a519d29616d7 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1118,8 +1118,6 @@ static int at91_twi_probe(struct platform_device *pdev)
>  
>  	rc = i2c_add_numbered_adapter(&dev->adapter);
>  	if (rc) {
> -		dev_err(dev->dev, "Adapter %s registration failed\n",
> -			dev->adapter.name);
>  		clk_disable_unprepare(dev->clk);
>  
>  		pm_runtime_disable(dev->dev);
> diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
> index c335cc7852f94e..d3bcaf4ab095d0 100644
> --- a/drivers/i2c/busses/i2c-axxia.c
> +++ b/drivers/i2c/busses/i2c-axxia.c
> @@ -558,13 +558,7 @@ static int axxia_i2c_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, idev);
>  
> -	ret = i2c_add_adapter(&idev->adapter);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to add adapter\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return i2c_add_adapter(&idev->adapter);
>  }
>  
>  static int axxia_i2c_remove(struct platform_device *pdev)
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 19c843828fe2ca..8e3477f9297eda 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -488,13 +488,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  
> -	ret = i2c_add_adapter(adap);
> -	if (ret) {
> -		dev_err(iproc_i2c->device, "failed to add adapter\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return i2c_add_adapter(adap);
>  }
>  
>  static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index ac9f47679c3a4b..a5c9098507896b 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -858,10 +858,8 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
>  	adap->dev.of_node = pdev->dev.of_node;
>  
>  	rc = i2c_add_adapter(adap);
> -	if (rc) {
> -		dev_err(dev->device, "failed to add adapter\n");
> +	if (rc)
>  		return rc;
> -	}
>  
>  	dev_info(dev->device, "device registered successfully\n");
>  
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 025686d4164058..29d00c4f7824c2 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -685,10 +685,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>  	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
>  
>  	rc = i2c_add_numbered_adapter(p_adap);
> -	if (rc < 0) {
> -		dev_err(&pdev->dev, "Can't add i2c adapter!\n");
> +	if (rc < 0)
>  		goto out_error;
> -	}
>  
>  	platform_set_drvdata(pdev, iface);
>  
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 3f5a4d71d3bf32..bc5c176e984aea 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -648,10 +648,8 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  	rc = i2c_add_adapter(adap);
> -	if (rc) {
> -		dev_err(dev->device, "failed to add adapter\n");
> +	if (rc)
>  		goto probe_errorout;
> -	}
>  
>  	dev_info(dev->device, "%s@%dhz registered in %s mode\n",
>  		 int_name ? int_name : " ", dev->clk_freq_hz,
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index 90bbd9f9dd8f77..1cc1e79e958d56 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -963,10 +963,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_adapter(&id->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "reg adap failed: %d\n", ret);
> +	if (ret < 0)
>  		goto err_clk_dis;
> -	}
>  
>  	/*
>  	 * Cadence I2C controller has a bug wherein it generates
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index ee57c1e865e271..d89bde2c5da256 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -665,10 +665,8 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
>  	cpm->adap.nr = (data && len == 4) ? be32_to_cpup(data) : -1;
>  	result = i2c_add_numbered_adapter(&cpm->adap);
>  
> -	if (result < 0) {
> -		dev_err(&ofdev->dev, "Unable to register with I2C\n");
> +	if (result < 0)
>  		goto out_shut;
> -	}
>  
>  	dev_dbg(&ofdev->dev, "hw routines for %s registered.\n",
>  		cpm->adap.name);
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> index a0d95ff682ae12..cf334a9ec22cb7 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -281,10 +281,8 @@ static int ec_i2c_probe(struct platform_device *pdev)
>  	bus->adap.retries = I2C_MAX_RETRIES;
>  
>  	err = i2c_add_adapter(&bus->adap);
> -	if (err) {
> -		dev_err(dev, "cannot register i2c adapter\n");
> +	if (err)
>  		return err;
> -	}
>  	platform_set_drvdata(pdev, bus);
>  
>  	return err;
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a8bdcb5292f5b3..9e7ef5cf5d495d 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -846,10 +846,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  
>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
> -	if (r) {
> -		dev_err(&pdev->dev, "failure adding adapter\n");
> +	if (r)
>  		goto err_unuse_clocks;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> index b19a310bf9b3e8..f718ee4e3332fe 100644
> --- a/drivers/i2c/busses/i2c-diolan-u2c.c
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> @@ -487,10 +487,8 @@ static int diolan_u2c_probe(struct usb_interface *interface,
>  
>  	/* and finally attach to i2c layer */
>  	ret = i2c_add_adapter(&dev->adapter);
> -	if (ret < 0) {
> -		dev_err(&interface->dev, "failed to add I2C adapter\n");
> +	if (ret < 0)
>  		goto error_free;
> -	}
>  
>  	dev_dbg(&interface->dev, "connected " DRIVER_NAME "\n");
>  
> diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
> index f2eb4f76591fbe..8acda2aa15583c 100644
> --- a/drivers/i2c/busses/i2c-dln2.c
> +++ b/drivers/i2c/busses/i2c-dln2.c
> @@ -228,10 +228,8 @@ static int dln2_i2c_probe(struct platform_device *pdev)
>  
>  	/* and finally attach to i2c layer */
>  	ret = i2c_add_adapter(&dln2->adapter);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to add I2C adapter: %d\n", ret);
> +	if (ret < 0)
>  		goto out_disable;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
> index e253598d764c0d..aa336ba89aa3fe 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -438,7 +438,6 @@ static int efm32_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_adapter(&ddata->adapter);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to add i2c adapter (%d)\n", ret);
>  		free_irq(ddata->irq, ddata);
>  
>  err_disable_clk:
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index c0e3ada028763d..bea607149972d4 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -796,10 +796,8 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
>  	exynos5_i2c_reset(i2c);
>  
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
> +	if (ret < 0)
>  		goto err_clk;
> -	}
>  
>  	platform_set_drvdata(pdev, i2c);
>  
> diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
> index 7c6966434ee7b9..ae7f3180f7e887 100644
> --- a/drivers/i2c/busses/i2c-hix5hd2.c
> +++ b/drivers/i2c/busses/i2c-hix5hd2.c
> @@ -478,10 +478,8 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
>  	pm_runtime_enable(priv->dev);
>  
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
> +	if (ret < 0)
>  		goto err_runtime;
> -	}
>  
>  	return ret;
>  
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 5ef9b733d153fa..22a0ed4de80da0 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1613,7 +1613,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		"SMBus I801 adapter at %04lx", priv->smba);
>  	err = i2c_add_adapter(&priv->adapter);
>  	if (err) {
> -		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
>  		i801_acpi_remove(priv);
>  		return err;
>  	}
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index cdaa7be2cd1b94..412b91d255ad1d 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -751,10 +751,8 @@ static int iic_probe(struct platform_device *ofdev)
>  	adap->timeout = HZ;
>  
>  	ret = i2c_add_adapter(adap);
> -	if (ret  < 0) {
> -		dev_err(&ofdev->dev, "failed to register i2c adapter\n");
> +	if (ret  < 0)
>  		goto error_cleanup;
> -	}
>  
>  	dev_info(&ofdev->dev, "using %s mode\n",
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
> index ea20425b697217..db8e8b40569d98 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1394,10 +1394,8 @@ static int img_i2c_probe(struct platform_device *pdev)
>  		goto disable_clk;
>  
>  	ret = i2c_add_numbered_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add adapter\n");
> +	if (ret < 0)
>  		goto disable_clk;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 1844bc9f7cd5a2..cb11eee9567318 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1129,10 +1129,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  
>  	/* Add I2C adapter */
>  	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "registration failed\n");
> +	if (ret < 0)
>  		goto rpm_disable;
> -	}
>  
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index c2f25f19d76f9b..0cf1379f4e8091 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -288,10 +288,8 @@ static int smbus_sch_probe(struct platform_device *dev)
>  		"SMBus SCH adapter at %04x", sch_smba);
>  
>  	retval = i2c_add_adapter(&sch_adapter);
> -	if (retval) {
> -		dev_err(&dev->dev, "Couldn't register adapter!\n");
> +	if (retval)
>  		sch_smba = 0;
> -	}
>  
>  	return retval;
>  }
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index 1c870771009840..f573448d213216 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -922,10 +922,8 @@ ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return err;
>  
>  	err = i2c_add_adapter(&priv->adapter);
> -	if (err) {
> -		dev_err(&pdev->dev, "Failed to add SMBus iSMT adapter\n");
> +	if (err)
>  		return -ENODEV;
> -	}
>  	return 0;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
> index cd9872594fe2a0..b8ea62105f42c9 100644
> --- a/drivers/i2c/busses/i2c-jz4780.c
> +++ b/drivers/i2c/busses/i2c-jz4780.c
> @@ -798,10 +798,8 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to add bus\n");
> +	if (ret < 0)
>  		goto err;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
> index 586a15205e61de..9b1fef455a895d 100644
> --- a/drivers/i2c/busses/i2c-lpc2k.c
> +++ b/drivers/i2c/busses/i2c-lpc2k.c
> @@ -432,10 +432,8 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
>  	i2c->adap.dev.of_node = pdev->dev.of_node;
>  
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add adapter!\n");
> +	if (ret < 0)
>  		goto fail_clk;
> -	}
>  
>  	dev_info(&pdev->dev, "LPC2K I2C adapter\n");
>  
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 71d3929adf54ed..102d2b91771f35 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -453,7 +453,6 @@ static int meson_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_adapter(&i2c->adap);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "can't register adapter\n");
>  		clk_unprepare(i2c->clk);
>  		return ret;
>  	}
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 48ecffecc0eda3..565a49a0c56410 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -737,10 +737,8 @@ static int fsl_i2c_probe(struct platform_device *op)
>  	i2c->adap.dev.of_node = of_node_get(op->dev.of_node);
>  
>  	result = i2c_add_adapter(&i2c->adap);
> -	if (result < 0) {
> -		dev_err(i2c->dev, "failed to add adapter\n");
> +	if (result < 0)
>  		goto fail_add;
> -	}
>  
>  	return result;
>  
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index d9373e60be8ae3..4a7d9bc2142ba3 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -786,10 +786,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add i2c bus to i2c core\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	platform_set_drvdata(pdev, i2c);
>  
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 033846cdf26622..5738556b6aac20 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -868,7 +868,6 @@ static int mxs_i2c_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(adap, i2c);
>  	err = i2c_add_numbered_adapter(adap);
>  	if (err) {
> -		dev_err(dev, "Failed to add adapter (%d)\n", err);
>  		writel(MXS_I2C_CTRL0_SFTRST,
>  				i2c->regs + MXS_I2C_CTRL0_SET);
>  		return err;
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> index 42fcc9458432f8..374b35e7e450ce 100644
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -366,7 +366,6 @@ static int nforce2_probe_smb(struct pci_dev *dev, int bar, int alt_reg,
>  
>  	error = i2c_add_adapter(&smbus->adapter);
>  	if (error) {
> -		dev_err(&smbus->adapter.dev, "Failed to register adapter.\n");
>  		release_region(smbus->base, smbus->size);
>  		return error;
>  	}
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index bcd17e8cbcb4b3..da6609d628487b 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -1046,10 +1046,8 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
>  		 adap->name, dev->virtbase);
>  
>  	ret = i2c_add_adapter(adap);
> -	if (ret) {
> -		dev_err(&adev->dev, "failed to add adapter\n");
> +	if (ret)
>  		goto err_no_adap;
> -	}
>  
>  	pm_runtime_put(&adev->dev);
>  
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index dfa7a4b4a91d78..92692349d0c328 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -492,10 +492,8 @@ static int ocores_i2c_probe(struct platform_device *pdev)
>  
>  	/* add i2c adapter to i2c tree */
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add adapter\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	/* add in known devices to the bus */
>  	if (pdata) {
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> index 30ae35146723a4..b75d2da79b27c5 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -1213,10 +1213,8 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, i2c);
>  
>  	result = i2c_add_adapter(&i2c->adap);
> -	if (result < 0) {
> -		dev_err(i2c->dev, "failed to add adapter\n");
> +	if (result < 0)
>  		goto out;
> -	}
>  	dev_info(i2c->dev, "probed\n");
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ab1279b8e2407a..c7da0c42baeefa 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1425,10 +1425,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	/* i2c device drivers may be active on return from add_adapter() */
>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
> -	if (r) {
> -		dev_err(omap->dev, "failure adding adapter\n");
> +	if (r)
>  		goto err_unuse_clocks;
> -	}
>  
>  	dev_info(omap->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
>  		 major, minor, omap->speed);
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 23d1c167b5d752..c2268cdf38e823 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -694,7 +694,6 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
>  
>  	retval = i2c_add_adapter(adap);
>  	if (retval) {
> -		dev_err(&dev->dev, "Couldn't register adapter!\n");
>  		kfree(adapdata);
>  		kfree(adap);
>  		release_region(smba, SMBIOSIZE);
> diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
> index 2c40edbf6224eb..217c78711d6501 100644
> --- a/drivers/i2c/busses/i2c-pmcmsp.c
> +++ b/drivers/i2c/busses/i2c-pmcmsp.c
> @@ -329,10 +329,8 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
>  	i2c_set_adapdata(&pmcmsptwi_adapter, &pmcmsptwi_data);
>  
>  	rc = i2c_add_adapter(&pmcmsptwi_adapter);
> -	if (rc) {
> -		dev_err(&pldev->dev, "Unable to register I2C adapter\n");
> +	if (rc)
>  		goto ret_unmap;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 7ea67aa46fb730..fd5f9d2bf6d94e 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -714,10 +714,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  
>  	/* Register this adapter with the I2C subsystem */
>  	ret = i2c_add_numbered_adapter(&alg_data->adapter);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
> +	if (ret < 0)
>  		goto out_clock;
> -	}
>  
>  	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
>  		alg_data->adapter.name, res->start, alg_data->irq);
> diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
> index 82b6f02544dae7..0c8b1571886d5b 100644
> --- a/drivers/i2c/busses/i2c-puv3.c
> +++ b/drivers/i2c/busses/i2c-puv3.c
> @@ -212,11 +212,8 @@ static int puv3_i2c_probe(struct platform_device *pdev)
>  
>  	adapter->nr = pdev->id;
>  	rc = i2c_add_numbered_adapter(adapter);
> -	if (rc) {
> -		dev_err(&pdev->dev, "Adapter '%s' registration failed\n",
> -				adapter->name);
> +	if (rc)
>  		goto fail_add_adapter;
> -	}
>  
>  	dev_info(&pdev->dev, "PKUnity v3 i2c bus adapter.\n");
>  	return 0;
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 0d351954db02b9..e28b825b043378 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1292,10 +1292,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  #endif
>  
>  	ret = i2c_add_numbered_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&dev->dev, "failed to add bus: %d\n", ret);
> +	if (ret < 0)
>  		goto ereqirq;
> -	}
>  
>  	platform_set_drvdata(dev, i2c);
>  
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 52407f3c9e1cce..400e344704d273 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -875,10 +875,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = i2c_add_numbered_adapter(adap);
> -	if (ret < 0) {
> -		dev_err(dev, "reg adap failed: %d\n", ret);
> +	if (ret < 0)
>  		goto out_pm_disable;
> -	}
>  
>  	dev_info(dev, "probed\n");
>  
> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
> index d7e3af67154373..6263ea82d6ac3b 100644
> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -383,10 +383,8 @@ static int riic_i2c_probe(struct platform_device *pdev)
>  
>  
>  	ret = i2c_add_adapter(adap);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to add adapter\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	platform_set_drvdata(pdev, riic);
>  
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 2bc8b01153d619..3b87afe82f6394 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1303,10 +1303,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>  	rk3x_i2c_adapt_div(i2c, clk_rate);
>  
>  	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Could not register adapter\n");
> +	if (ret < 0)
>  		goto err_clk_notifier;
> -	}
>  
>  	dev_info(&pdev->dev, "Initialized RK3xxx I2C bus at %p\n", i2c->regs);
>  
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 38dc1cacfd8bba..499af26e736e7e 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1215,7 +1215,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_numbered_adapter(&i2c->adap);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
>  		pm_runtime_disable(&pdev->dev);
>  		s3c24xx_i2c_deregister_cpufreq(i2c);
>  		clk_unprepare(i2c->clk);
> diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
> index 24968384b4014f..c2005c789d2b09 100644
> --- a/drivers/i2c/busses/i2c-sh7760.c
> +++ b/drivers/i2c/busses/i2c-sh7760.c
> @@ -510,10 +510,8 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_numbered_adapter(&id->adap);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "reg adap failed: %d\n", ret);
> +	if (ret < 0)
>  		goto out4;
> -	}
>  
>  	platform_set_drvdata(pdev, id);
>  
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 6fb3e264599229..50f276e8d17967 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -981,7 +981,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>  	ret = i2c_add_numbered_adapter(adap);
>  	if (ret < 0) {
>  		sh_mobile_i2c_release_dma(pd);
> -		dev_err(&dev->dev, "cannot add numbered adapter\n");
>  		return ret;
>  	}
>  
> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
> index 792a42bdd335b9..95e81d0f72b4d2 100644
> --- a/drivers/i2c/busses/i2c-sirf.c
> +++ b/drivers/i2c/busses/i2c-sirf.c
> @@ -387,10 +387,8 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
>  		writel(regval, siic->base + SIRFSOC_I2C_SDA_DELAY);
>  
>  	err = i2c_add_numbered_adapter(adap);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "Can't add new i2c adapter\n");
> +	if (err < 0)
>  		goto out;
> -	}
>  
>  	clk_disable(clk);
>  
> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
> index 944ec420508487..1371547ce1a3a8 100644
> --- a/drivers/i2c/busses/i2c-st.c
> +++ b/drivers/i2c/busses/i2c-st.c
> @@ -874,10 +874,8 @@ static int st_i2c_probe(struct platform_device *pdev)
>  	init_completion(&i2c_dev->complete);
>  
>  	ret = i2c_add_adapter(adap);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add adapter\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	platform_set_drvdata(pdev, i2c_dev);
>  
> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
> index 460c134832ac30..dc63236b45b216 100644
> --- a/drivers/i2c/busses/i2c-stu300.c
> +++ b/drivers/i2c/busses/i2c-stu300.c
> @@ -920,11 +920,8 @@ static int stu300_probe(struct platform_device *pdev)
>  
>  	/* i2c device drivers may be active on return from add_adapter() */
>  	ret = i2c_add_numbered_adapter(adap);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failure adding ST Micro DDC "
> -		       "I2C adapter\n");
> +	if (ret)
>  		return ret;
> -	}
>  
>  	platform_set_drvdata(pdev, dev);
>  	dev_info(&pdev->dev, "ST DDC I2C @ %p, irq %d\n",
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index b126dbaa47e370..d9979da11485ae 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -932,10 +932,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->adapter.dev.of_node = pdev->dev.of_node;
>  
>  	ret = i2c_add_numbered_adapter(&i2c_dev->adapter);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add I2C adapter\n");
> +	if (ret)
>  		goto disable_div_clk;
> -	}
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
> index aeead0d27d1007..64318e69089439 100644
> --- a/drivers/i2c/busses/i2c-uniphier-f.c
> +++ b/drivers/i2c/busses/i2c-uniphier-f.c
> @@ -550,15 +550,10 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
> -err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
>  
> + err:
>  	return ret;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
> index 475a5eb514e215..94f64cccfdef08 100644
> --- a/drivers/i2c/busses/i2c-uniphier.c
> +++ b/drivers/i2c/busses/i2c-uniphier.c
> @@ -407,15 +407,10 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
> -err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
>  
> + err:
>  	return ret;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
> index e1e3a85596c562..fbd0fd59f31239 100644
> --- a/drivers/i2c/busses/i2c-wmt.c
> +++ b/drivers/i2c/busses/i2c-wmt.c
> @@ -432,10 +432,8 @@ static int wmt_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	err = i2c_add_adapter(adap);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to add adapter\n");
> +	if (err)
>  		return err;
> -	}
>  
>  	platform_set_drvdata(pdev, i2c_dev);
>  
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
> index 4233f5695352fd..263685c7a51287 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -418,7 +418,6 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(adapter, ctx);
>  	rc = i2c_add_adapter(adapter);
>  	if (rc) {
> -		dev_err(&pdev->dev, "Adapter registeration failed\n");
>  		mbox_free_channel(ctx->mbox_chan);
>  		return rc;
>  	}
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 74f54f2f471fa7..66bce3b311a199 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -804,7 +804,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  	/* add i2c adapter to i2c tree */
>  	ret = i2c_add_adapter(&i2c->adap);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add adapter\n");
>  		xiic_deinit(i2c);
>  		goto err_clk_dis;
>  	}
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index 55a7bef1b2e1df..2a972ed7aa0df1 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -400,10 +400,8 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(&priv->adapter, priv);
>  
>  	err = i2c_add_adapter(&priv->adapter);
> -	if (err) {
> -		dev_err(&pdev->dev, "failed to add I2C adapter!\n");
> +	if (err)
>  		return err;
> -	}
>  
>  	platform_set_drvdata(pdev, priv);
>  	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
> diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
> index 613c3a4f2c5142..0968f59b6df586 100644
> --- a/drivers/i2c/busses/i2c-xlr.c
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -432,10 +432,8 @@ static int xlr_i2c_probe(struct platform_device *pdev)
>  
>  	i2c_set_adapdata(&priv->adap, priv);
>  	ret = i2c_add_numbered_adapter(&priv->adap);
> -	if (ret < 0) {
> -		dev_err(&priv->adap.dev, "Failed to add i2c bus.\n");
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	platform_set_drvdata(pdev, priv);
>  	dev_info(&priv->adap.dev, "Added I2C Bus.\n");
> -- 
> 2.8.1
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
