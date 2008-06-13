Return-Path: <agl@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CAF8DDF4D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:03:49 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5DE3h0u023350
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:03:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DE3Vhg135672
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:03:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5DE3Uop003702
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:03:31 -0600
Subject: Re: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig options
From: Adam Litke <agl@us.ibm.com>
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20080613134629.GD16344@linux-mips.org>
References: <1213296540.17108.8.camel@localhost.localdomain>
	<20080613134629.GD16344@linux-mips.org>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:03:28 -0400
Message-Id: <1213365808.15016.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: npiggin@suse.de, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, mel@csn.ul.ie, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	linux-mips@linux-mips.org, nacc@us.ibm.com,
	sparclinux@vger.kernel.org, Eric B Munson <ebmunson@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-13 at 14:46 +0100, Ralf Baechle wrote:
> MIPS doesn't do HUGETLB (at least not in-tree atm) so I'm not sure why
> linux-mips@linux-mips.org was cc'ed at all.  So feel free to add my
> Couldnt-care-less: ack line ;-)

Sorry :)  My patches touched your defconfigs so I felt it prudent to
include the mips list as an FYI.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
