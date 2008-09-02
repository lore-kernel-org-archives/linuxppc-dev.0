Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35FD9DE04E
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:07:39 +1000 (EST)
Subject: Re: [Libhugetlbfs-devel] Buglet in 16G page handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20080902124442.GD29766@csn.ul.ie>
References: <20080902050510.GB12965@yookeroo.seuss>
	<20080902124442.GD29766@csn.ul.ie>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 07:05:07 +1000
Message-Id: <1220389507.13010.147.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Tollefson <kniht@linux.vnet.ibm.com>,
	libhugetlbfs-devel@lists.sourceforge.net
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Actually, Jon has been hitting an occasional pagetable lock related
> problem. The last theory was that it might be some sort of race but it's
> vaguely possible that this is the issue. Jon?

All hugetlbfs ops should be covered by the big PTL except walking... Can
we have more info about the problem ?

Cheers,
Ben.
