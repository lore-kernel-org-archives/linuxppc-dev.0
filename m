Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id 56F2F2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 13:41:40 +1000 (EST)
Date: Wed, 05 Sep 2012 23:41:35 -0400 (EDT)
Message-Id: <20120905.234135.1451998549380446225.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [powerpc:next 24/29] drivers/atm/fore200e.h:263:3: error:
 redefinition of typedef 'opcode_t' with different type
From: David Miller <davem@davemloft.net>
In-Reply-To: <1346900172.19098.17.camel@pasglop>
References: <20120906021929.GA16076@localhost>
 <1346900172.19098.17.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, mroos@linux.ee, fengguang.wu@intel.com,
 kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Sep 2012 12:56:12 +1000

> (CC'ing Dave and Meelis who from the git history *might* have HW access
> to test a possible patch).

Hardware isn't necessary, just make sure the resulting binary is
identical both before and after the change.
