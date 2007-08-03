Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 98409DDE16
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 06:40:19 +1000 (EST)
Message-ID: <46B39063.6070301@intel.com>
Date: Fri, 03 Aug 2007 13:30:27 -0700
From: "Kok, Auke" <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Andrew Gallatin <gallatin@myri.com>
Subject: Re: [PATCH] lro: myri10ge example how to use LRO
References: <46B363A8.4010407@myri.com>
In-Reply-To: <46B363A8.4010407@myri.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Gallatin wrote:
> To follow up on Jan-Bernd Themann's LRO patch earlier today,
> this patch shows how the generic LRO interface can be used for
> page based drivers.
> 
> Again, many thanks to Jan-Bernd Themann for leading this effort.
> 
> Drew
> 
> Singed off by: Andrew Gallatin <gallatin@myri.com>
> 


please take a look at my lro patch for ethtool and see if it works for you, 
instead of adding another generic module parameter that doesn't need to be there.

Thanks.

Auke
