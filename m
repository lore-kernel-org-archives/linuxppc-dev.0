Return-Path: <tmarri@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	by ozlabs.org (Postfix) with SMTP id 190CAB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 09:13:03 +1100 (EST)
Received: by mail-qw0-f51.google.com with SMTP id 5so282521qwg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 14:13:02 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <1295477836-14589-1-git-send-email-tmarri@apm.com>
	<20110123030150.GA28358@kroah.com>
In-Reply-To: <20110123030150.GA28358@kroah.com>
MIME-Version: 1.0
Date: Tue, 25 Jan 2011 14:06:41 -0800
Message-ID: <5fc573f3ae6c3de2c5bbfe0052a45f5e@mail.gmail.com>
Subject: RE: [PATCH V8 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Saturday, January 22, 2011 7:02 PM
To: tmarri@apm.com
Cc: linux-usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V8 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver

On Wed, Jan 19, 2011 at 02:57:16PM -0800, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
> v8:
>  1. Add set_wedge to usb_ep_ops.
>
> v7:
>  1. Fix sparse tool warnings.
>  2. Fix checkpatch errors and warnings.
>  3. Rename USB_OTG config variable to USB_DWC_CONFIG
>
> Tirumala Marri (10):
>   USB/ppc4xx: Add Synopsys DWC OTG Register definitions
>   USB/ppc4xx: Add Synopsys DWC OTG driver framework
>   USB/ppc4xx: Add Synopsys DWC OTG Core Interface Layer
>   USB/ppc4xx: Add Synopsys DWC OTG HCD function
>   USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt function
>   USB/ppc4xx: Add Synopsys DWC OTG HCD queue function
>   USB/ppc4xx: Add Synopsys DWC OTG PCD function
>   USB ppc4xx: Add Synopsys DWC OTG PCD interrupt function
>   USB/ppc4xx:Synopsys DWC OTG driver enable gadget support
>   USB ppc4xx: Add Synopsys DWC OTG driver kernel configuration and
>     Makefile
>
>  drivers/Makefile                        |    2 +
>  drivers/usb/Kconfig                     |    3 +-
>  drivers/usb/dwc_otg/Kconfig             |   96 ++

Why are you creating a new subdirectory here?  Shouldn't it be in
drivers/usb/otg/dwc/ instead?

>  drivers/usb/dwc_otg/Makefile            |   19 +
>  drivers/usb/dwc_otg/dwc_otg_apmppc.c    |  414 ++++++
>  drivers/usb/dwc_otg/dwc_otg_cil.c       |  972 ++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_cil.h       | 1220 +++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_cil_intr.c  |  616 ++++++++
>  drivers/usb/dwc_otg/dwc_otg_driver.h    |   76 +
>  drivers/usb/dwc_otg/dwc_otg_hcd.c       | 2466
+++++++++++++++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_hcd.h       |  416 ++++++
>  drivers/usb/dwc_otg/dwc_otg_hcd_intr.c  | 1477 ++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_hcd_queue.c |  696 +++++++++
>  drivers/usb/dwc_otg/dwc_otg_param.c     |  180 +++
>  drivers/usb/dwc_otg/dwc_otg_pcd.c       | 1766 ++++++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_pcd.h       |  139 ++
>  drivers/usb/dwc_otg/dwc_otg_pcd_intr.c  | 2311
+++++++++++++++++++++++++++++
>  drivers/usb/dwc_otg/dwc_otg_regs.h      | 1325 +++++++++++++++++

As you are in your own subdir, no need to put "dwc_otg_" at the start of
every file name, right?

Care to make these changes and resend?

[Marri] Sure I will make changes and resend.
-Marri
