Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sGKlf1KYHzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 10:02:37 +1000 (AEST)
Date: Fri, 19 Aug 2016 17:02:25 -0700 (PDT)
Message-Id: <20160819.170225.1435790645345872728.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jallen@linux.vnet.ibm.com
Subject: Re: [PATCH] ibmvnic: Handle backing device failover and
 reinitialization
From: David Miller <davem@davemloft.net>
In-Reply-To: <1471538271-10131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1471538271-10131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
Date: Thu, 18 Aug 2016 11:37:51 -0500

> An upcoming feature of IBM VNIC protocol is the ability to configure
> redundant backing devices for a VNIC client. In case of a failure
> on the current backing device, the driver will receive a signal
> from the hypervisor indicating that a failover will occur. The driver
> will then wait for a message from the backing device before 
> establishing a new connection.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied.
