Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B7A0CDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:20:21 +1000 (EST)
Date: Wed, 14 May 2008 23:20:14 -0700 (PDT)
Message-Id: <20080514.232014.34303310.davem@davemloft.net>
To: kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH] list_for_each_rcu must die: networking
From: David Miller <davem@davemloft.net>
In-Reply-To: <482BC96F.1030008@linux.vnet.ibm.com>
References: <20080424033849.GA4401@linux.vnet.ibm.com>
	<20080515001607.GB20811@linux.vnet.ibm.com>
	<482BC96F.1030008@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, adobriyan@gmail.com,
	akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
	shemminger@vyatta.com, sri@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Thu, 15 May 2008 10:56:07 +0530

> Paul E. McKenney wrote:
> > All uses of list_for_each_rcu() can be profitably replaced by the
> > easier-to-use list_for_each_entry_rcu().  This patch makes this change
> > for networking, in preparation for removing the list_for_each_rcu()
> > API entirely.
> > 
> > Updated to remove the two now-unused variables as noted by Dave Miller,
> > and also to fix my bonehead error detected by Kamalesh Babulal and
> > Alexey Dobriyan.  It now passes LTP on POWER.  And also has valid SOB.
> > Some days it just doesn't pay to get out of bed...
> 
> Hi Paul,
> 
> Thanks, the patch fixes the oops.
> 
> Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > Acked-by: David S. Miller <davem@davemloft.net> (lkml.org/lkml/2008/4/23/448)
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

I'm fine with these changes, and I acked them already.
They belong as a set with the other list_for_each_rcu killing
patches, so I'm fine with them going all together in Andrew's
tree.

Thanks!
