Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXWDK5XQfzF0XP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 06:59:42 +1100 (AEDT)
Date: Thu, 01 Feb 2018 14:59:35 -0500 (EST)
Message-Id: <20180201.145935.1511421104143236233.davem@davemloft.net>
To: desnesn@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
Subject: Re: [PATCH, net] ibmvnic: fix firmware version when no firmware
 level has been provided by the VIOS server
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
References: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
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

From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Date: Thu,  1 Feb 2018 16:04:30 -0200

> Older versions of VIOS servers do not send the firmware level in the VPD
> buffer for the ibmvnic driver. Thus, not only the current message is mis-
> leading but the firmware version in the ethtool will be NULL. Therefore,
> this patch fixes the firmware string and its warning.
> 
> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>

Applied.

Please do not put empty lines between Fixes: and Signed-off-by: and other
tags, all tags are equal and are placed together in an uninterrupted
sequences of consequetive lines.

Thank you.
