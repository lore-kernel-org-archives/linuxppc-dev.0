Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 250D0DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:03:15 +1000 (EST)
Date: Fri, 01 May 2009 15:03:07 -0700 (PDT)
Message-Id: <20090501.150307.195064038.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH 5/6 v2] net/ucc_geth: Assign six threads to Rx for UEC
From: David Miller <davem@davemloft.net>
In-Reply-To: <F2CB7830-33F9-4F6C-A782-6B086166FC4D@kernel.crashing.org>
References: <1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
	<F2CB7830-33F9-4F6C-A782-6B086166FC4D@kernel.crashing.org>
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
Date: Fri, 1 May 2009 16:56:19 -0500

> 
> On May 1, 2009, at 2:40 PM, Haiying Wang wrote:
> 
>> in the case the QE has 46 SNUMs for the threads to support four UCC
>> Ethernet at
>> 1000Base-T simultaneously.
>>
>> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
>> ---
>> v2 change: Add comments for the Rx threads change.
>> drivers/net/ucc_geth.c |   10 +++++++++-
>> 1 files changed, 9 insertions(+), 1 deletions(-)
> 
> Dave,
> 
> One more patch for you to Ack and let me handle via the powerpc tree
> because of dependencies.

Acked-by: David S. Miller <davem@davemloft.net>
