Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 32FB0DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 09:51:52 +1100 (EST)
Date: Tue, 28 Oct 2008 15:51:28 -0700 (PDT)
Message-Id: <20081028.155128.144329082.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
From: David Miller <davem@davemloft.net>
In-Reply-To: <49065942.4040300@nortel.com>
References: <4902B1D8.8070800@nortel.com>
	<20081025.001703.261277154.davem@davemloft.net>
	<49065942.4040300@nortel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	romieu@fr.zoreil.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Mon, 27 Oct 2008 18:13:54 -0600

> [PATCH] fix amd8111e rx return code
> 
> The amd8111e rx poll routine currently mishandles the case when we process
> exactly the number of packets specified in the budget.
> 
> This patch is basically as suggested by David Miller.
> 
> Signed-off-by: Chris Friesen <cfriesen@nortel.com>

I had to apply this by hand because your email client heavily
corrupted the patch.

Thanks.
