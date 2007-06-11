Return-Path: <rzhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id C2CCFDDED0
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 18:00:00 +1000 (EST)
Subject: Re: [PATCH 3/6] 82xx: Add the support of Wind River SBC
	PowerQUICCII 82xx
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070609192516.092ff1b6@vitb.ru.mvista.com>
References: <1181292878.11341.15.camel@mark>
	<20070609192516.092ff1b6@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 15:59:36 +0800
Message-Id: <1181548776.5217.18.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

Since you will cover this issue, so I will remove this chunk from my
patch, and re-submit my patches.

Thanks
Mark Zhan
On Sat, 2007-06-09 at 19:25 +0400, Vitaly Bordug wrote:
> On Fri, 08 Jun 2007 16:54:38 +0800
> Mark Zhan <rongkai.zhan@windriver.com> wrote:
> 
> >  			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
> > -							(u32)res.start, fs_enet_data.phy_addr);
> > +				fs_enet_dev->id, fs_enet_data.phy_addr);
> > +
> >  			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
> 
> Have to admit this is not correct. The issue is in fs_enet code (which should take mdio bus id, not device id), and I'll cover it.
> 
