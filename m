Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CAE82DDEBA
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 01:25:15 +1000 (EST)
Date: Sat, 9 Jun 2007 19:25:16 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH 3/6] 82xx: Add the support of Wind River SBC
	PowerQUICCII 82xx
Message-ID: <20070609192516.092ff1b6@vitb.ru.mvista.com>
In-Reply-To: <1181292878.11341.15.camel@mark>
References: <1181292878.11341.15.camel@mark>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 08 Jun 2007 16:54:38 +0800
Mark Zhan <rongkai.zhan@windriver.com> wrote:

>  			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
> -							(u32)res.start, fs_enet_data.phy_addr);
> +				fs_enet_dev->id, fs_enet_data.phy_addr);
> +
>  			fs_enet_data.bus_id = (char*)&bus_id[(*id)];

Have to admit this is not correct. The issue is in fs_enet code (which should take mdio bus id, not device id), and I'll cover it.

-- 
Sincerely, 
Vitaly
