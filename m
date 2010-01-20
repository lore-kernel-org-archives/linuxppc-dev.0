Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0E104B7CDC
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 15:04:30 +1100 (EST)
Date: Tue, 19 Jan 2010 20:04:39 -0800 (PST)
Message-Id: <20100119.200439.193706380.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 02/11] fs_enet: Add FEC TX Alignment workaround for MPC5121
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100120104225.3361e6c4.sfr@canb.auug.org.au>
References: <1263932653-3634-3-git-send-email-agust@denx.de>
	<20100119.123706.12493208.davem@davemloft.net>
	<20100120104225.3361e6c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kosmo@semihalf.com, jrigby@freescale.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, agust@denx.de, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Jan 2010 10:42:25 +1100

> On Tue, 19 Jan 2010 12:37:06 -0800 (PST) David Miller <davem@davemloft.net> wrote:
>>
>> Well... where are the other 9 patches?
> 
> I think the other 9 are not network related, just PowerPC related.

Ok, but that's very confusing.

If it's meant to go into two different trees split the
patches up into two different series.
