Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40TpPp2FwZzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 11:13:47 +1000 (AEST)
Date: Sun, 22 Apr 2018 21:13:41 -0400 (EDT)
Message-Id: <20180422.211341.912127868555832199.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net] ibmvnic: Clean actual number of RX or TX pools
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524252332-10272-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1524252332-10272-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
Date: Fri, 20 Apr 2018 14:25:32 -0500

> Avoid using value stored in the login response buffer when
> cleaning TX and RX buffer pools since these could be inconsistent
> depending on the device state. Instead use the field in the driver's
> private data that tracks the number of active pools.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied.
