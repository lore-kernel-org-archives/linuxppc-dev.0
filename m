Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id DBD772C0090
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2013 08:15:30 +1100 (EST)
Date: Tue, 12 Feb 2013 16:15:26 -0500 (EST)
Message-Id: <20130212.161526.1610493155978768216.davem@davemloft.net>
To: sr@denx.de
Subject: Re: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <1360660088-27464-1-git-send-email-sr@denx.de>
References: <1360660088-27464-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, agust@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>
Date: Tue, 12 Feb 2013 10:08:08 +0100

> Until now, the MPC5200 FEC ethernet driver relied upon the bootloader
> (U-Boot) to write the MAC address into the ethernet controller
> registers. The Linux driver should not rely on such a thing. So
> lets read the MAC address from the DT as it should be done here.
> 
> The following priority is now used to read the MAC address:
> 
> 1) First, try OF node MAC address, if not present or invalid, then:
> 
> 2) Read from MAC address registers, if invalid, then:
> 
> 3) Log a warning message, and choose a random MAC address.
> 
> This fixes a problem with a MPC5200 board that uses the SPL U-Boot
> version without FEC initialization before Linux booting for
> boot speedup.
> 
> Additionally a status line is now be printed upon successful
> driver probing, also displaying this MAC address.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Applied.
