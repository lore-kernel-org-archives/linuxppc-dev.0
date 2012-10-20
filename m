Return-Path: <chf.fritz@googlemail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B208C2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 06:12:41 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id dq12so1116303wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2012 12:12:36 -0700 (PDT)
Subject: Re: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
From: Christoph Fritz <chf.fritz@googlemail.com>
To: balbi@ti.com
In-Reply-To: <20121019104416.GH11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
 <20121019103039.GF11191@arwen.pp.htv.fi> <1350643608.3709.78.camel@mars>
 <20121019104416.GH11191@arwen.pp.htv.fi>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Oct 2012 21:12:27 +0200
Message-ID: <1350760347.3669.3.camel@mars>
Mime-Version: 1.0
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

On Fri, 2012-10-19 at 13:44 +0300, Felipe Balbi wrote:
> > I thought about this too but wasn't able to use chipidea with
> > MXC_EHCI_INTERNAL_PHY as it's called in fsl_udc.
> 
> that's a matter of writing the PHY driver, right ;-) It has nothing to
> do with chipidea, actually :-)

Okay, I'll do. But then we should purge the old buggy fsl_udc.

 Thanks
   -- Christoph
