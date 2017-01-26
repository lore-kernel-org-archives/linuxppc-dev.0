Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v87c86M6NzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 15:05:12 +1100 (AEDT)
Date: Wed, 25 Jan 2017 23:05:04 -0500 (EST)
Message-Id: <20170125.230504.215468934911959234.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 wvoigt@us.ibm.com, nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net 2/5] ibmvnic: Fix MTU settings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1485378143-5084-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1485378143-5084-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
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

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 25 Jan 2017 15:02:20 -0600

> In the current driver, the MTU is set to the maximum value
> capable for the backing device. This patch sets the MTU to the
> default value for a Linux net device.

Why are you doing this?

What happens to users who depend upon the current behavior.

They will break, and that isn't acceptable.
