Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qfly858NXzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 09:52:00 +1000 (AEST)
Date: Tue, 05 Apr 2016 19:51:57 -0400 (EDT)
Message-Id: <20160405.195157.2030686647042617056.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jallen@linux.vnet.ibm.com
Subject: Re: [net-next PATCH 1/2 v4] ibmvnic: map L2/L3/L4 header
 descriptors to firmware
From: David Miller <davem@davemloft.net>
In-Reply-To: <1459549235-22039-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1459549235-22039-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
Date: Fri,  1 Apr 2016 17:20:34 -0500

> Allow the VNIC driver to provide descriptors containing
> L2/L3/L4 headers to firmware.  This feature is needed
> for greater hardware compatibility and enablement of checksum
> and TCP offloading features.
> 
> A new function is included for the hypervisor call,
> H_SEND_SUBCRQ_INDIRECT, allowing a DMA-mapped array of SCRQ
> descriptor elements to be sent to the VNIC server.
> 
> These additions will help fully enable checksum offloading as
> well as other features as they are included later.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied.
