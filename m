Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id F01101A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 06:36:39 +1100 (AEDT)
Date: Tue, 03 Mar 2015 14:36:34 -0500 (EST)
Message-Id: <20150303.143634.1288503571033945996.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Subject: Re: [PATCH v3] ibmveth: Add function to enable live MAC address
 changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1425318972-19455-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1425318972-19455-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jiri@resnulli.us
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon,  2 Mar 2015 11:56:12 -0600

> Add a function that will enable changing the MAC address
> of an ibmveth interface while it is still running.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied, thanks.
