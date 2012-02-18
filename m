Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A721B6F99
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2012 02:40:28 +1100 (EST)
Received: by bkcjc3 with SMTP id jc3so3986323bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 07:40:20 -0800 (PST)
Message-ID: <4F3FC619.8050809@mvista.com>
Date: Sat, 18 Feb 2012 19:39:05 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 16-02-2012 14:02, Shengzhou Liu wrote:

> If USB UTMI PHY is not enable, writing to portsc register will lead to
> kernel hang during boot up.

> Signed-off-by: Shengzhou Liu<Shengzhou.Liu@freescale.com>
[...]

> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index bdf43e2..0e400c2 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -45,6 +45,7 @@
>   #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
>   #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
>   #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
> +#define CTRL_UTMI_PHY_EN	(1<<9)

    Please put spaces around << like below.

>   #define CTRL_PHY_CLK_VALID	(1<<  17)
>   #define SNOOP_SIZE_2GB		0x1e
>   #endif				/* _EHCI_FSL_H */

WBR, Sergei
