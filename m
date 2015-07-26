Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id CED631A036E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 09:35:23 +1000 (AEST)
Date: Sun, 26 Jul 2015 16:35:20 -0700 (PDT)
Message-Id: <20150726.163520.846046458508685868.davem@davemloft.net>
To: madalin.bucur@freescale.com
Cc: joe@perches.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 Igal.Liberman@freescale.com, ppc@mindchasers.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se
Subject: Re: [PATCH 03/10] dpaa_eth: add configurable bpool thresholds
From: David Miller <davem@davemloft.net>
In-Reply-To: <BL2PR03MB545AA0E6D98232FF43B6CE9E6810@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1437581806-17420-3-git-send-email-madalin.bucur@freescale.com>
 <1437587228.20787.26.camel@perches.com>
 <BL2PR03MB545AA0E6D98232FF43B6CE9E6810@BL2PR03MB545.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
Date: Fri, 24 Jul 2015 15:49:39 +0000

>> -----Original Message-----
>> From: Joe Perches [mailto:joe@perches.com]
>> On Wed, 2015-07-22 at 19:16 +0300, Madalin Bucur wrote:
>> > Allow the user to tweak the refill threshold and the total number
>> > of buffers in the buffer pool. The provided values are for one CPU.
>> 
>> Any value in making these module parameters instead?
> 
> I expect one would (hardly ever) change these to improve some corner
> cases then use them with the new values. It may help in the tuning process
> but afterwards the bloat to the bootcmd would probably be  a nuisance.

I think these should be controlled by the existing ethtool infrastructure.

Neither the Kconfig mechanism nor module parameters are appropriate, at all.
