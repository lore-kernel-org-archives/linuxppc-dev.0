Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E0E4B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 06:22:30 +1100 (EST)
Received: by wyg36 with SMTP id 36so3472346wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 12:22:26 -0700 (PDT)
Message-ID: <4D962588.9050800@ru.mvista.com>
Date: Fri, 01 Apr 2011 23:20:40 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v11 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1301684736-17647-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1301684736-17647-1-git-send-email-tmarri@apm.com>
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

tmarri@apm.com wrote:

> From: Tirumala Marri <tmarri@apm.com>

> Add Synopsys DesignWare HS USB OTG driver kernel configuration.
> Synopsys OTG driver may operate in  host only, device only, or OTG mode.
> The driver also allows user configure the core to use its internal DMA
> or Slave (PIO) mode.

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
[...]

> diff --git a/drivers/Makefile b/drivers/Makefile
> index a125e0b..500e08f 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_UWB)		+= uwb/
>  obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/otg/dwc/

    Haven't we recently agreed with Greg on drivers/usb/dwc/?

WBR, Sergei
