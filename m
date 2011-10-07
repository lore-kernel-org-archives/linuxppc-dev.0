Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with SMTP id 87D89B70B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2011 22:15:04 +1100 (EST)
Message-ID: <4E8EDD75.5090107@ru.mvista.com>
Date: Fri, 07 Oct 2011 15:07:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v14 10/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
 support
References: <1317954673-12032-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1317954673-12032-1-git-send-email-tmarri@apm.com>
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

On 07-10-2011 6:31, tmarri@apm.com wrote:

> From: Tirumala Marri<tmarri@apm.com>

> Enable gadget support

> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> Signed-off-by: Fushen Chen<fchen@apm.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
[...]

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 5a084b9..5f1f89f 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -316,6 +316,17 @@ config USB_GADGET_MUSB_HDRC
>   	  This OTG-capable silicon IP is used in dual designs including
>   	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
>
> +# dwc_otg builds in ../dwc along with host support
> +config USB_GADGET_DWC_HDRC
> +	boolean "DesignWare USB Peripheral"
> +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
> +	select USB_GADGET_DUALSPEED
> +	select USB_GADGET_SELECTED
> +	select USB_GADGET_DWC_OTG

    I don't see where this one is defined...

WBR, Sergei
