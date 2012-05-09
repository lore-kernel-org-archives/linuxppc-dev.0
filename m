Return-Path: <chf.fritz@googlemail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A449DB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 16:04:33 +1000 (EST)
Received: by wibhr2 with SMTP id hr2so52632wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2012 23:04:30 -0700 (PDT)
Date: Wed, 9 May 2012 08:04:24 +0200
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Neil Zhang <zhangwm@marvell.com>
Subject: Re: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Message-ID: <20120509060424.GB3910@lovely.krouter>
References: <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
 <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
 <20120509053826.GA3492@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49D9@SC-VEXCH4.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49D9@SC-VEXCH4.marvell.com>
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>,
 Fabio Estevam <festevam@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Neil,

 thanks for you help.

> > 
> > What about the fix for mv_udc, shouldn't they have a similar
> > "limitation"? How do you explain?
> > Or maybe someone from Marvell has an answer?
> > 
> 
> Yes, we encountered the same issue, and I have answered your question several hours ago.
> Please have a look.

Thanks for that.
Relating to the other *udc.c driver, do you think they should implement
a similar workaround there too or at least check their errataS?

Thanks,
 -- Christoph
