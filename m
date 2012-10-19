Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 269562C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:23:36 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so110976bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:23:32 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/7] update USB gadget driver fsl-usb2-udc
Date: Fri, 19 Oct 2012 12:22:36 +0200
Message-Id: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <20120521190450.GA27492@arwen.pp.htv.fi>
References: <20120521190450.GA27492@arwen.pp.htv.fi>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series updates USB gadget driver fsl-usb2-udc.

Christoph Fritz (7):
  usb: gadget: fsl_udc: simplify driver init
  usb: gadget: fsl_udc: protect fsl_pullup() with spin_lock
  usb: gadget: fsl_udc: convert to new ulc style
  usb: gadget: fsl_udc: drop ARCH dependency
  usb: gadget: fsl_udc: postpone freeing current dTD
  usb: gadget: fsl_udc: purge global pointer usb_sys_regs
  usb: gadget: fsl_udc: purge global pointer dr_regs

 drivers/usb/gadget/fsl_udc_core.c |  755 ++++++++++++++++---------------------
 drivers/usb/gadget/fsl_usb2_udc.h |    4 +
 2 files changed, 322 insertions(+), 437 deletions(-)

-- 
1.7.2.5
