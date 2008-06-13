Return-Path: <ralf@linux-mips.org>
Received: from vigor.karmaclothing.net (vigor.karmaclothing.net
	[217.169.26.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1536DDF5E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:29:33 +1000 (EST)
Date: Fri, 13 Jun 2008 14:46:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig options
Message-ID: <20080613134629.GD16344@linux-mips.org>
References: <1213296540.17108.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213296540.17108.8.camel@localhost.localdomain>
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

On Thu, Jun 12, 2008 at 02:49:00PM -0400, Adam Litke wrote:

> There are currently two global Kconfig options that enable/disable the
> hugetlb code: CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS.  This may have
> made sense before hugetlbfs became ubiquitous but now the pair of
> options are redundant.  Merging these two options into one will simplify
> the code slightly and will, more importantly, avoid confusion and
> questions like: Which hugetlbfs CONFIG option should my code depend on?
> 
> CONFIG_HUGETLB_PAGE is aliased to the value of CONFIG_HUGETLBFS, so one
> option can be removed without any effect.  The first patch merges the
> two options into one option: CONFIG_HUGETLB.  The second patch updates
> the defconfigs to set the one new option appropriately.
> 
> I have cross-compiled this on i386, x86_64, ia64, powerpc, sparc64 and
> sh with the option enabled and disabled.  This is completely mechanical
> but, due to the large number of files affected (especially defconfigs),
> could do well with a review from several sets of eyeballs.  Thanks.

MIPS doesn't do HUGETLB (at least not in-tree atm) so I'm not sure why
linux-mips@linux-mips.org was cc'ed at all.  So feel free to add my
Couldnt-care-less: ack line ;-)

  Ralf
