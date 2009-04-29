Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EF96DDDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 07:51:53 +1000 (EST)
Date: Wed, 29 Apr 2009 14:51:45 -0700 (PDT)
Message-Id: <20090429.145145.49692653.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH 3/6] net/ucc_geth: update riscTx and riscRx in ucc_geth
From: David Miller <davem@davemloft.net>
In-Reply-To: <F640C411-797C-4A4D-BD1B-9A20114C57C3@kernel.crashing.org>
References: <12410288792524-git-send-email-Haiying.Wang@freescale.com>
	<12410288811793-git-send-email-Haiying.Wang@freescale.com>
	<F640C411-797C-4A4D-BD1B-9A20114C57C3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Haiying.Wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 29 Apr 2009 15:23:21 -0500

> 
> On Apr 29, 2009, at 1:14 PM, Haiying Wang wrote:
> 
>> Change the definition of riscTx and riscRx to unsigned integer instead
>> of enum,
>> and change their values to support 4 risc allocation if the qe has 4
>> RISC
>> engines.
>>
>> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
>> ---
> 
> Dave, if you can ack this it is probably easier if this goes via the
> powerpc tree as it had some dependancies.

Fair enough:

Acked-by: David S. Miller <davem@davemloft.net>
