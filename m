Return-Path: <sshtylyov@mvista.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC201B6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Apr 2011 00:00:16 +1100 (EST)
Received: by wwi36 with SMTP id 36so4121883wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Apr 2011 06:00:12 -0700 (PDT)
Message-ID: <4D971D7E.2010900@ru.mvista.com>
Date: Sat, 02 Apr 2011 16:58:38 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v12 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1301694975-604-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1301694975-604-1-git-send-email-tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello.

On 02-04-2011 1:56, tmarri@apm.com wrote:

> From: Tirumala Marri <tmarri@apm.com>

> Add Synopsys DesignWare HS USB OTG driver kernel configuration.
> Synopsys OTG driver may operate in  host only, device only, or OTG mode.
> The driver also allows user configure the core to use its internal DMA
> or Slave (PIO) mode.

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
[...]

> diff --git a/drivers/usb/dwc/Kconfig b/drivers/usb/dwc/Kconfig
> new file mode 100644
> index 0000000..a8f22cb
> --- /dev/null
> +++ b/drivers/usb/dwc/Kconfig
> @@ -0,0 +1,88 @@
> +#
> +# USB Dual Role (OTG-ready) Controller Drivers
> +# for silicon based on Synopsys DesignWare IP
> +#
[...]
> +# enable peripheral support (including with OTG)
> +config USB_GADGET_DWC_HDRC
> +	bool
> +	depends on USB_DWC_OTG&&  (DWC_DEVICE_ONLY || USB_DWC_OTG)
> +

    I've already told you not to redefine it.

WBR, Sergei
