Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F18FDDEE7
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 20:29:18 +1100 (EST)
Subject: Re: [PowerPC] 2.6.29-rc3-git4 build break : truncated relocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <49880C42.8060702@in.ibm.com>
References: <49880C42.8060702@in.ibm.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 20:28:53 +1100
Message-Id: <1233653333.16867.85.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-03 at 14:50 +0530, Sachin P. Sant wrote:
> 2.6.29-rc3-git4 allyesconfig build breaks with following error

I think it's the recurrent problem of allyesconfig generating a kernel
too big for our linker especially when ftrace is enabled.

We need to see if it's worth the pain of working around it with the
toolchain guys. Probably not tho...

Ben.
