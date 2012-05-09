Return-Path: <B29397@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D464AB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 15:43:20 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Christoph Fritz <chf.fritz@googlemail.com>, Chao Xie <cxie4@marvell.com>
Subject: RE: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Date: Wed, 9 May 2012 05:43:11 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B93001@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
 <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
 <20120509053826.GA3492@lovely.krouter>
In-Reply-To: <20120509053826.GA3492@lovely.krouter>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>, Neil Zhang <zhangwm@marvell.com>,
 Fabio Estevam <festevam@gmail.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>=20
> I'm hacking here an i.MX35 not an i.MX23. So I already had a look at its
> errata sheet http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> but didn't find a similar "limitation" as you now pointed out by errata
> number 2858 for i.MX23.
>

i.mx35 and i.mx23 uses the same controller.
=20
> What about the fix for mv_udc, shouldn't they have a similar
> "limitation"? How do you explain?
> Or maybe someone from Marvell has an answer?
>
It is probably that others who use chipidea core have the same problem,
but it needs to get confirm from them. =20

>=20
> Thanks,
>  -- Christoph
