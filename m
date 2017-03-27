Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vsV0Y3dPMzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 10:02:21 +1100 (AEDT)
Date: Mon, 27 Mar 2017 16:02:19 -0700 (PDT)
Message-Id: <20170327.160219.2206810160004593215.davem@davemloft.net>
To: tklauser@distanz.ch
Cc: tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: ibmvnic: Remove unused net_stats member
 from struct ibmvnic_adapter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170327065659.27307-1-tklauser@distanz.ch>
References: <20170327065659.27307-1-tklauser@distanz.ch>
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

From: Tobias Klauser <tklauser@distanz.ch>
Date: Mon, 27 Mar 2017 08:56:59 +0200

> The ibmvnic driver keeps its statistics in net_device->stats, so the
> net_stats member in struct ibmvnic_adapter is unused. Remove it.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied.
