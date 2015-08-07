Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 2789F1A017D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 08:37:18 +1000 (AEST)
Date: Fri, 07 Aug 2015 15:37:16 -0700 (PDT)
Message-Id: <20150807.153716.1393797980617992919.davem@davemloft.net>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 igal.liberman@freescale.com, ppc@mindchasers.com, joe@perches.com,
 pebolle@tiscali.nl, joakim.tjernlund@transmode.se
Subject: Re: [v2 8/9] dpaa_eth: add debugfs entries
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438789289-16304-9-git-send-email-madalin.bucur@freescale.com>
References: <1438789289-16304-1-git-send-email-madalin.bucur@freescale.com>
 <1438789289-16304-9-git-send-email-madalin.bucur@freescale.com>
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

From: Madalin Bucur <madalin.bucur@freescale.com>
Date: Wed, 5 Aug 2015 18:41:28 +0300

> Export per CPU counters through debugfs.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>

This is absolutely inappropriate.

You can export these just fine via ethtool statistics.  There is zero reason
to add ugly debugfs crap for something like this.
