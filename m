Return-Path: <shawn.guo@linaro.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3F802C022F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 22:35:53 +1100 (EST)
Date: Fri, 11 Jan 2013 19:35:44 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130111113543.GA2080@S2101-09.ap.freescale.net>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111105651.GF11085@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130111105651.GF11085@arwen.pp.htv.fi>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Peter Chen <peter.chen@freescale.com>, kernel@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2013 at 12:56:51PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > to determine the SoC type, and updates the platform code accordingly.
> > 
> > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > Tested at mx51 bbg board, it works ok after enable phy clock
> > (Need another patch to fix this problem)
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> this is too big for -rc, can you break it down into smaller pieces ?
> 
This is a patch missed from my series that enables multiplatform
support for IMX (because the driver is not enabled in defconfig,
sorry).  To me, it's logically one patch to convert the driver over
to use platform_device_id.  It does not make much sense to split it.

Shawn
