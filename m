Return-Path: <sshtylyov@mvista.com>
Received: from mail-ey0-f172.google.com (mail-ey0-f172.google.com
	[209.85.215.172]) by ozlabs.org (Postfix) with ESMTP id B34AAB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 00:25:45 +1100 (EST)
Received: by eyd10 with SMTP id 10so1596053eyd.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Dec 2010 05:25:42 -0800 (PST)
Message-ID: <4D00D89B.6020208@ru.mvista.com>
Date: Thu, 09 Dec 2010 16:24:43 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH V6 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
	support
References: <1291854755-25103-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1291854755-25103-1-git-send-email-tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mark Miesfeld <mmiesfeld@apm.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 09-12-2010 3:32, tmarri@apm.com wrote:

> From: Tirumala Marri<tmarri@apm.com>

> Enable gadget support

> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> Signed-off-by: Fushen Chen<fchen@apm.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
[...]

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 747b0d3..b2bcc4e 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
[...]
> +config USB_OTG
> +	boolean "OTG Support"

    This symbol is already defined in drivers/usb/core/Kconfig.

WBR, Sergei
