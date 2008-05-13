Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8308DDDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 10:41:59 +1000 (EST)
Date: Mon, 12 May 2008 17:41:51 -0700 (PDT)
Message-Id: <20080512.174151.193690130.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2]: LMB small bug fix and debugging tidy up.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikpe@it.uu.se, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


While diagnosing Mikael's bug where half of his RAM disappeared
in 2.6.26-rc2 I found one bug (which I don't think fixes his
problem, but waiting for an updated set of debugging logs from
him) and an improvement to the debugging provided by the current
LMB code.
