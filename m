Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C161DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 16:30:01 +1100 (EST)
Message-Id: <1E43CE53-98E0-4D98-9629-9E3336A25BAE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080219.212655.173468988.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [LMB]: Fix lmb_add_region if region should be added at
	the head
Date: Tue, 19 Feb 2008 23:29:55 -0600
References: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
	<20080219.204525.193731674.davem@davemloft.net>
	<7A7ECF09-E547-4C04-A388-C3E8755478DD@kernel.crashing.org>
	<20080219.212655.173468988.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2008, at 11:26 PM, David Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Tue, 19 Feb 2008 23:16:18 -0600
>
>> The for loop above the code I added will move all the existing slots
>> up one.  Its just the tail cleanup we are missing.
>
> Aha, I see how this works now, thanks!
>
> I'll add this to my LMB tree.

Sounds good.  Now just convince Paul or Linus to pull this in for  
2.6.25 :)

- k
