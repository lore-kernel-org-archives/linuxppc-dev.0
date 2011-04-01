Return-Path: <tmarri@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 0DBFEB6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 08:24:01 +1100 (EST)
Received: by mail-gy0-f182.google.com with SMTP id 13so1832956gyg.13
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 14:23:58 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1301684736-17647-1-git-send-email-tmarri@apm.com>
	<4D962588.9050800@ru.mvista.com>
In-Reply-To: <4D962588.9050800@ru.mvista.com>
MIME-Version: 1.0
Date: Fri, 1 Apr 2011 14:23:58 -0700
Message-ID: <de7f66c2a03ec9fc17d30acdb23f35c6@mail.gmail.com>
Subject: RE: [PATCH v11 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
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

> +++ b/drivers/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_UWB)		+= uwb/
>  obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/otg/dwc/

    Haven't we recently agreed with Greg on drivers/usb/dwc/?
[marri] I did not see Greg's response saying yes. I thought we are still
sticking with usb/otg/dwc.
