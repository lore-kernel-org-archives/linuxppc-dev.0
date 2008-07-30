Return-Path: <cl@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AC67DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 05:41:45 +1000 (EST)
Message-ID: <4890C3A5.8050700@linux-foundation.org>
Date: Wed, 30 Jul 2008 14:40:21 -0500
From: Christoph Lameter <cl@linux-foundation.org>
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014308.2a447e71.akpm@linux-foundation.org>
	<20080730172317.GA14138@csn.ul.ie>
	<20080730103407.b110afc2.akpm@linux-foundation.org>
	<20080730193010.GB14138@csn.ul.ie>
In-Reply-To: <20080730193010.GB14138@csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Hastings <abh@cray.com>, Eric Munson <ebmunson@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mel Gorman wrote:

> With Erics patch and libhugetlbfs, we can automatically back text/data[1],
> malloc[2] and stacks without source modification. Fairly soon, libhugetlbfs
> will also be able to override shmget() to add SHM_HUGETLB. That should cover
> a lot of the memory-intensive apps without source modification.

So we are quite far down the road to having a VM that supports 2 page sizes 4k and 2M?
