Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4289104785
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 22:41:02 +1100 (EST)
Received: by bkcjc3 with SMTP id jc3so2023353bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2012 03:40:58 -0800 (PST)
Message-ID: <4F2A7604.9060102@mvista.com>
Date: Thu, 02 Feb 2012 15:39:48 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH v2] powerpc/usb: fix issue of CPU halt when missing USB
 PHY clock
References: <1328152994-2879-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1328152994-2879-1-git-send-email-Shengzhou.Liu@freescale.com>
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

On 02-02-2012 7:23, Shengzhou Liu wrote:

> when missing USB PHY clock, kernel booting up will halt during USB
> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> CPU hang in this case.

> Signed-off-by: Shengzhou Liu<Shengzhou.Liu@freescale.com>
[...]

> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index 4918062..dd3dc47 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -45,5 +45,6 @@
>   #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
>   #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
>   #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
> +#define CTRL_PHY_CLK_VALID      (1 << 17)

    Indent the macro value with tabs please.

WBR, Sergei
