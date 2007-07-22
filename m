Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0EB54DDE1F
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 12:29:05 +1000 (EST)
Date: Sat, 21 Jul 2007 19:29:04 -0700 (PDT)
Message-Id: <20070721.192904.10298367.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [RFC 1/1] lro: Generic Large Receive Offload for TCP traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <200707201741.49290.ossthema@de.ibm.com>
References: <200707201741.49290.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, meder@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Fri, 20 Jul 2007 17:41:48 +0200

> Generic LRO patch
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

I have no general objections to this patch.

However I'd like to see at least one or two uses of these APIs before
we put it in, and it sounds as if we have at least two pending and
in the works if not ready already, so that shouldn't be an issue.

Thanks.
