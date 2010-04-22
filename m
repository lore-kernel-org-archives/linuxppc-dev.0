Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BD70AB7D16
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 15:36:17 +1000 (EST)
Date: Wed, 21 Apr 2010 22:36:20 -0700 (PDT)
Message-Id: <20100421.223620.257172362.davem@davemloft.net>
To: tklein@de.ibm.com
Subject: Re: [PATCH 1/2][RESEND] ehea: error handling improvement
From: David Miller <davem@davemloft.net>
In-Reply-To: <201004211110.55986.tklein@de.ibm.com>
References: <201004211110.55986.tklein@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, themann@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Klein <tklein@de.ibm.com>
Date: Wed, 21 Apr 2010 11:10:55 +0200

> Reset a port's resources only if they're actually in an error state
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> ---
> 
> Patch created against net-2.6

I thought you were sorry for wasting my time and that you were going
to follow the directions I gave you last time, and I quote:

--------------------
3) These are not appropriate for net-2.6 as we are deep in
   the -rcX series at this point and only the most diabolical
   bug fixes are appropriate.  Therefore, please generate these
   against net-next-2.6, thanks.
--------------------

And here you are generating your patches against net-2.6.  Heck, you
even feel it's worth mentioning explicitly.

Lucky for you the patches happen to apply cleanly to net-next-2.6 so
I've put them there.
