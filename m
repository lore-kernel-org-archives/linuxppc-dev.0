Return-Path: <shawn.guo@linaro.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FF242C010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 12:12:37 +1100 (EST)
Date: Mon, 14 Jan 2013 09:12:43 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114011241.GC24575@S2101-09.ap.freescale.net>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111125059.GA12715@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130111125059.GA12715@arwen.pp.htv.fi>
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

Balbi,

On Fri, Jan 11, 2013 at 02:50:59PM +0200, Felipe Balbi wrote:
> As I said before, this patch is too big for -rc and is unnecessary
> considering patch I wrote above. Note that there is no problems in
> checking if ULPI PHY clk is 60MHz on all arches and, for the workaround,
> you already have a runtime check.
> 
Ok, I did not have these facts on my mind.  If these are true, the
cpu_is_xxx() shouldn't be necessary there from the beginning, and we
can simply remove them then.

> Shawn, it can be broken down into smaller pieces because you can *FIX
> THE COMPILE BREAKAGE* with a very small patch as above (only issue now
> is usage of MX32_IO_ADDRESS()).
> 
The MX35_IO_ADDRESS() also seems unnecessary, since as Peter's patch
suggested that pdata->regs can be used instead.

Shawn
