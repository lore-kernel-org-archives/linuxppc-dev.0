Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 34045B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 02:48:38 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EAF4ADDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 02:48:37 +1000 (EST)
Date: Fri, 17 Jul 2009 09:48:41 -0700 (PDT)
Message-Id: <20090717.094841.175615379.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 1/2 v5] fs_enet/mii-fec.c: fix MII speed calculation
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40907170741n121d3e4cqdfddaf4d23d4d1fc@mail.gmail.com>
References: <1247780546-4426-1-git-send-email-wd@denx.de>
	<1247833628-15952-1-git-send-email-wd@denx.de>
	<fa686aa40907170741n121d3e4cqdfddaf4d23d4d1fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Jul 2009 08:41:08 -0600

> On Fri, Jul 17, 2009 at 6:27 AM, Wolfgang Denk<wd@denx.de> wrote:
>> The MII speed calculation was based on the CPU clock (ppc_proc_freq),
>> but for MPC512x we must use the bus clock instead.
>>
>> This patch makes it use the correct clock and makes sure we don't
>> clobber reserved bits in the MII_SPEED register.
>>
>> Signed-off-by: Wolfgang Denk <wd@denx.de>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: <netdev@vger.kernel.org>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Applied to net-next-2.6
