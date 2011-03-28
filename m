Return-Path: <tmarri@apm.com>
Received: from exprod5og116.obsmtp.com (exprod5og116.obsmtp.com [64.18.0.147])
	by ozlabs.org (Postfix) with SMTP id F2659B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 04:29:04 +1100 (EST)
Received: by mail-yi0-f41.google.com with SMTP id 18so1239791yib.0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Mar 2011 10:29:02 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1297119242-28562-1-git-send-email-tmarri@apm.com>
	<4D518B2D.3090603@ru.mvista.com>
In-Reply-To: <4D518B2D.3090603@ru.mvista.com>
MIME-Version: 1.0
Date: Mon, 28 Mar 2011 10:23:23 -0700
Message-ID: <5540911d2e000414054d989bbdc32f2c@mail.gmail.com>
Subject: RE: [PATCH V9 10/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
To: Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +config DWC_DEVICE_ONLY
> +	bool "DWC Device Only Mode"
> +	select USB_GADGET_SELECTED
> +
> +endchoice

    So this is tri-modal driver after all... how come we place it in
drivers/usb/otg/dwc/, while the same tri-modal MUSB driver was placed in
drivers/usb/musb/?

[Marri] Initially this was how the patch created. Greg KH, suggested to
move under OTG.
