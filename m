Return-Path: <shawn.guo@linaro.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A575A2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 22:00:39 +1100 (EST)
Date: Thu, 17 Jan 2013 19:01:05 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v6 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
Message-ID: <20130117110104.GO26179@S2101-09.ap.freescale.net>
References: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
 <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
 <20130117105833.GP10814@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130117105833.GP10814@arwen.pp.htv.fi>
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

On Thu, Jan 17, 2013 at 12:58:33PM +0200, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 06:03:17PM +0800, Peter Chen wrote:
> > As we use platform_device_id for fsl-usb2-udc driver, it needs to
> > change clk connection-id, or the related devm_clk_get will be failed.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> 
> do I get Acked-by for this one ?

Acked-by: Shawn Guo <shawn.guo@linaro.org>
