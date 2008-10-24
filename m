Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 26EBCDDDFD
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:41:52 +1100 (EST)
Date: Fri, 24 Oct 2008 16:41:28 -0700 (PDT)
Message-Id: <20081024.164128.113131091.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: [BUG] oops in net_rx_action on 64-bit powerpc
From: David Miller <davem@davemloft.net>
In-Reply-To: <49025C94.60406@nortel.com>
References: <F169D4F5E1F1974DBFAFABF47F60C10A069DFCEF@orsmsx507.amr.corp.intel.com>
	<20081023.171614.72881694.davem@davemloft.net>
	<49025C94.60406@nortel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, romieu@fr.zoreil.com, jesse.brandeburg@intel.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Fri, 24 Oct 2008 17:39:00 -0600

> So...it would appear that the NAPI code is somehow buggy, and
> 6ba33ac should probably be reverted until the problem is found and
> fixed.

No I think the problem is simple enough that someone should study the
->poll() routine quickly and audit it's return values.
