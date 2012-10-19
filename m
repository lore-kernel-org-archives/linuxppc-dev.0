Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B9902C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2012 02:36:46 +1100 (EST)
Date: Fri, 19 Oct 2012 17:36:33 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 0/7] update USB gadget driver fsl-usb2-udc
Message-ID: <20121019153633.GT27665@pengutronix.de>
References: <20120521190450.GA27492@arwen.pp.htv.fi>
 <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 linuxppc-dev@lists.ozlabs.org, Teresa Gamez <T.Gamez@phytec.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

What system are you working on? If it's i.MX you should use/work on the
chipidea driver instead.

Sascha

On Fri, Oct 19, 2012 at 12:22:36PM +0200, Christoph Fritz wrote:
> This series updates USB gadget driver fsl-usb2-udc.
> 
> Christoph Fritz (7):
>   usb: gadget: fsl_udc: simplify driver init
>   usb: gadget: fsl_udc: protect fsl_pullup() with spin_lock
>   usb: gadget: fsl_udc: convert to new ulc style
>   usb: gadget: fsl_udc: drop ARCH dependency
>   usb: gadget: fsl_udc: postpone freeing current dTD
>   usb: gadget: fsl_udc: purge global pointer usb_sys_regs
>   usb: gadget: fsl_udc: purge global pointer dr_regs
> 
>  drivers/usb/gadget/fsl_udc_core.c |  755 ++++++++++++++++---------------------
>  drivers/usb/gadget/fsl_usb2_udc.h |    4 +
>  2 files changed, 322 insertions(+), 437 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
