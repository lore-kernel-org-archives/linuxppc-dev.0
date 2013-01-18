Return-Path: <shawn.guo@linaro.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2795F2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 13:23:05 +1100 (EST)
Date: Fri, 18 Jan 2013 10:23:39 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v7 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
Message-ID: <20130118022337.GA29282@S2101-09.ap.freescale.net>
References: <1358475349-27710-1-git-send-email-peter.chen@freescale.com>
 <1358475349-27710-4-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1358475349-27710-4-git-send-email-peter.chen@freescale.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter,

On Fri, Jan 18, 2013 at 10:15:49AM +0800, Peter Chen wrote:
> As we use platform_device_id for fsl-usb2-udc driver, it needs to
> change clk connection-id, or the related devm_clk_get will be failed.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

You should have my ACK put after your SoB, since I have provided it
on v6 of this patch.  It will make balbi's life a little bit easier
when he applies the patch.

So again,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Shawn
