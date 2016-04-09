Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qhjs40w6jzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 14:24:23 +1000 (AEST)
Date: Sat, 09 Apr 2016 00:24:14 -0400 (EDT)
Message-Id: <20160409.002414.1397876007087320930.davem@davemloft.net>
To: jallen@linux.vnet.ibm.com
Cc: tlfalcon@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] ibmvnic: Enable use of multiple tx/rx scrqs
From: David Miller <davem@davemloft.net>
In-Reply-To: <57053E33.6020706@linux.vnet.ibm.com>
References: <57053E33.6020706@linux.vnet.ibm.com>
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

From: John Allen <jallen@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 11:49:55 -0500

> Enables the use of multiple transmit and receive scrqs allowing the ibmvnic
> driver to take advantage of multiqueue functionality. To achieve this, the
> driver must implement the process of negotiating the maximum number of
> queues allowed by the server. Initially, the driver will attempt to login
> with the maximum number of tx and rx queues supported by the server. If
> the server fails to allocate the requested number of scrqs, it will return
> partial success in the login response. In this case, we must reinitiate
> the login process from the request capabilities stage and attempt to login
> requesting fewer scrqs.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

Applied, thanks.
