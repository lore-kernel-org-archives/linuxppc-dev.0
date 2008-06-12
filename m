Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 3BE03DE454
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 05:37:50 +1000 (EST)
Date: Thu, 12 Jun 2008 22:36:40 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Adam Litke <agl@us.ibm.com>
Subject: Re: [RFC PATCH 2/2] Update defconfigs for CONFIG_HUGETLB
Message-ID: <20080612193638.GB17231@cs181133002.pp.htv.fi>
References: <1213296540.17108.8.camel@localhost.localdomain>
	<1213296945.17108.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1213296945.17108.13.camel@localhost.localdomain>
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

On Thu, Jun 12, 2008 at 02:55:45PM -0400, Adam Litke wrote:
> Update all defconfigs that specify a default configuration for hugetlbfs.
> There is now only one option: CONFIG_HUGETLB.  Replace the old
> CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS options with the new one.  I found no
> cases where CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE had different values so
> this patch is large but completely mechanical:
>...
>  335 files changed, 335 insertions(+), 385 deletions(-)
>...

Please don't do this kind of patches - it doesn't bring any advantage 
but can create tons of patch conflicts.

The next time a defconfig gets updated it will anyway automatically be 
fixed, and for defconfigs that aren't updated it doesn't create any 
problems to keep them as they are today until they might one day get 
updated.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
