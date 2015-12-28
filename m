Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id BF9FE1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 16:13:23 +1100 (AEDT)
Date: Mon, 28 Dec 2015 00:12:49 -0500 (EST)
Message-Id: <20151228.001249.1417336567416640306.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, nguyendo@us.ibm.com,
 formosa@us.ibm.com, tyreld@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net-next v3] Driver for IBM System i/p VNIC protocol
From: David Miller <davem@davemloft.net>
In-Reply-To: <1450718766-22605-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1450718766-22605-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
Date: Mon, 21 Dec 2015 11:26:06 -0600

> This is a new device driver for a high performance SR-IOV assisted virtual
> network for IBM System p and IBM System i systems.  The SR-IOV VF will be
> attached to the VIOS partition and mapped to the Linux client via the
> hypervisor's VNIC protocol that this driver implements.
> 
> This driver is able to perform basic tx and rx, new features
> and improvements will be added as they are being developed and tested.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

Applied, thanks.
