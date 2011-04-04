Return-Path: <balbi@ti.com>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5543FB6FAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Apr 2011 23:59:35 +1000 (EST)
Received: by eya28 with SMTP id 28so1616788eya.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 06:59:31 -0700 (PDT)
Date: Mon, 4 Apr 2011 16:59:28 +0300
From: Felipe Balbi <balbi@ti.com>
To: tmarri@apm.com
Subject: Re: [PATCH v13 09/10] USB ppc4xx: Add Synopsys DWC OTG driver
	kernel configuration and Makefile
Message-ID: <20110404135927.GQ2461@legolas.emea.dhcp.ti.com>
References: <1301872644-3074-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301872644-3074-1-git-send-email-tmarri@apm.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 03, 2011 at 04:17:24PM -0700, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> Add Synopsys DesignWare HS USB OTG driver kernel configuration.
> Synopsys OTG driver may operate in  host only, device only, or OTG mode.
> The driver also allows user configure the core to use its internal DMA
> or Slave (PIO) mode.
> 
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/Makefile         |    1 +
>  drivers/usb/Kconfig      |    2 +
>  drivers/usb/dwc/Kconfig  |   84 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc/Makefile |   19 ++++++++++
>  4 files changed, 106 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/dwc/Kconfig
>  create mode 100644 drivers/usb/dwc/Makefile
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index a125e0b..d4133a6 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_UWB)		+= uwb/
>  obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/dwc/

another one ? Greg, I know MUSB is also wrong, but can we avoid adding
more guys to drivers/Makefile and use drivers/usb/Makefile instead ?

Promise I'll send a patch to MUSB for next merge window :-)

-- 
balbi
