Return-Path: <festevam@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B0BBEB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 11:17:40 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so28187bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 18:17:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339530031.3454.16.camel@mars>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com> <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>
 <1338809424.3371.20.camel@mars> <1338809853.3371.31.camel@mars>
 <CAOMZO5B7+Qy06m7O=v1M3vt7to7ciKOhQOihVgAEf+utntvw4w@mail.gmail.com>
 <1339530031.3454.16.camel@mars>
Date: Tue, 12 Jun 2012 22:17:36 -0300
Message-ID: <CAOMZO5CitYj+R+r=Z-ovRKO-kWaPPxBedY7WpKj2-SAk5WAS=w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
From: Fabio Estevam <festevam@gmail.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Oliver Neukum <oneukum@suse.de>, Eric Miao <eric.y.miao@gmail.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2012 at 4:40 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> Thanks for your patch. It does indeed load
> "Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)"
> fine - but now when I want to use it:
>
> modprobe g_ether
> [ =C2=A0 17.099363] g_ether gadget: using random self ethernet address
> [ =C2=A0 17.105316] g_ether gadget: using random host ethernet address
> [ =C2=A0 17.111974] usb0: MAC 1a:c7:9e:76:cc:45
> [ =C2=A0 17.115866] usb0: HOST MAC 66:a2:4a:0a:46:17
> [ =C2=A0 17.120199] g_ether gadget: Ethernet Gadget, version: Memorial Da=
y 2008
> [ =C2=A0 17.126861] g_ether gadget: g_ether ready
>
> these are "the last words": System hangs completely. Same behavior with
> g_serial (these two I've tested).

Ok, I just sent a new patch to the linux-usb mailing list.

Tested it on a mx31 and mx51 and it probed g_ether fine. I don't have
a mx35 handy.

>
> Currently I can't investigate this further, not because of a bug - but a
> flu.

Hope you get better soon.

Regards,

Fabio Estevam
