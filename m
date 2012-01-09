Return-Path: <b29397@nchen-desktop.ap.freescale.net>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0DEC0B6F71
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 13:12:55 +1100 (EST)
Date: Mon, 9 Jan 2012 10:12:21 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Nikolai Zhubr <n-a-zhubr@yandex.ru>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
Message-ID: <20120109021220.GA10198@nchen-desktop>
References: <4F088122.4080505@yandex.ru>
 <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
 <4F099291.6060803@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4F099291.6060803@yandex.ru>
Cc: support@amlogic.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openwrt-devel@lists.openwrt.org,
 Peter Chen <hzpeterchen@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 08, 2012 at 04:56:49PM +0400, Nikolai Zhubr wrote:
> Hello Piter,
> 
> 08.01.2012 7:12, you wrote:
> >2012/1/8 Nikolai Zhubr<n-a-zhubr@yandex.ru>:
> >
> >Please see:
> >http://marc.info/?l=linux-usb&m=129906859817430&w=2
> Ah, thanks. So sadly uncoordinated work in this area is quite
> common. However, in case of Synopsys the situation is even more
> disappointing because initially it _was_ a single driver! What
> probably lacked was some shared repository and proper communication
> between developers to stay in sync. Maybe there were also licensing
> issues at some point, though currently file headers contain rather
> reasonable (imho) permissive license from Synopsys.
> 
> >I am not sure we can combine all Synopsys USB drivers to single file, but we
> 
> Synopsys driver which I examine consists of 16 files (each of 2
> versions), 200k lines total. I've already perpared some few smaller
> files for version merging. So probably it is doable, but quite a lot
> of work, therefore I wouldn't like it to be wasted.
I mean one file is just a common udc driver for all Synopsys, not all usb file.
For ehci, I think it will be easier to use single file as well as 
some specific SoC's quirks if needed.
For udc, as there is no standard spec for how usb device should be designed,
maybe different Synopsys IPs have a little different for work flow.
For otg, it  should be not difficult after we split PHY's operation
from the otg, as common otg operation is the same.
> 
> >can try combine similar IP versions to one file, this work may need all Synopsys
> >USB IP driver maintainer work together.
> 
> Exactly. This is why I'm now trying to find all relevant people to
> begin with.
I know someone(@Pengutronix and @linux.intel.com) is doing that. I think first
we should find which driver file at current code base is most capable and
compatible. I would like to help it, and verify it at Freescale i.MX SoCs.
> 
> Thank you.
> Nikolai.
> 
> Please CC me, I'm not subscribed to the lists.
> 
> 
> >
> >
> >>Thank you.
> >>Nikolai.
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
