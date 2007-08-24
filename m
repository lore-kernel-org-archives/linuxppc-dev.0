Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6F3DFDDE3E
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:43:45 +1000 (EST)
Date: Fri, 24 Aug 2007 14:43:43 -0700 (PDT)
Message-Id: <20070824.144343.95051903.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070824164541.GG4282@austin.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
	<20070824164541.GG4282@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 24 Aug 2007 11:45:41 -0500

> In the end, I just let it be, and let the system work as a
> busy-beaver, with the high interrupt rate. Is this a wise thing to
> do?

The tradeoff is always going to be latency vs. throughput.

A sane default should defer enough to catch multiple packets coming in
at something close to line rate, but not so much that latency unduly
suffers.
