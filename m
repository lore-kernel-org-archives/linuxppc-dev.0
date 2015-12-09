Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 381201A1045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 13:40:59 +1100 (AEDT)
Date: Tue, 08 Dec 2015 21:40:55 -0500 (EST)
Message-Id: <20151208.214055.912759732176162258.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, andrew@lunn.ch
Subject: Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
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

 From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 8 Dec 2015 17:44:02 -0500

> This file was originally cloned off of the MPC8641D-HPCN reference
> platform, which actually had a PHY IRQ line connected.  However
> this board does not.  The bogus entry was largely inert and went
> undetected until commit 321beec5047af83db90c88114b7e664b156f49fe
> ("net: phy: Use interrupts when available in NOLINK state") was
> added to the tree.
> 
> With the above commit, the board fails to NFS boot since it sits
> waiting for a PHY IRQ event that of course never arrives.  Removing
> the bogus entries from the DTS file fixes the issue.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I'm assuming this will go via the powerpc tree, not mine.
