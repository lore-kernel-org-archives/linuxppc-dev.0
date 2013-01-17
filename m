Return-Path: <festevam@gmail.com>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A338D2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 22:13:23 +1100 (EST)
Received: by mail-vc0-f175.google.com with SMTP id fy7so2336152vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 03:13:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
Date: Thu, 17 Jan 2013 09:13:19 -0200
Message-ID: <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
From: Fabio Estevam <festevam@gmail.com>
To: Peter Chen <peter.chen@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2013 at 8:01 AM, Peter Chen <peter.chen@freescale.com> wrote:

>         /* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> -       if (!cpu_is_mx51()) {
> +       if (!strcmp(pdev->id_entry->name, "imx-udc-mx27")) {]]

Shouldn't this be:
 if (!strcmp(pdev->id_entry->name, "imx-udc-mx51"))
