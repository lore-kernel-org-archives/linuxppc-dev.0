Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 1F67D2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 06:58:37 +1000 (EST)
Date: Sun, 05 May 2013 16:58:34 -0400 (EDT)
Message-Id: <20130505.165834.1729189703178834015.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] net/eth/ibmveth: Fixup retrieval of MAC address
From: David Miller <davem@davemloft.net>
In-Reply-To: <1367637541.4389.135.camel@pasglop>
References: <1367637541.4389.135.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: bhutchings@solarflare.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 04 May 2013 13:19:01 +1000

> Some ancient pHyp versions used to create a 8 bytes local-mac-address
> property in the device-tree instead of a 6 bytes one for veth.
> 
> The Linux driver code to deal with that is an insane hack which also
> happens to break with some choices of MAC addresses in qemu by testing
> for a bit in the address rather than just looking at the size of the
> property.
> 
> Sanitize this by doing the latter instead.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

Applied, thanks.
