Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 072331A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 19:33:10 +1000 (AEST)
Date: Thu, 14 May 2015 10:33:04 +0100
From: Mel Gorman <mgorman@suse.de>
To: Haren Myneni <hmyneni@gmail.com>
Subject: Re: mm: BUG_ON with NUMA_BALANCING (kernel BUG at
 include/linux/swapops.h:131!)
Message-ID: <20150514093304.GS2462@suse.de>
References: <CACgMoiK61mKYFpfhhK51uvkvFHK3k+Dz4peMnbeW7-npDu4XBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CACgMoiK61mKYFpfhhK51uvkvFHK3k+Dz4peMnbeW7-npDu4XBQ@mail.gmail.com>
Cc: srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 13, 2015 at 01:17:54AM -0700, Haren Myneni wrote:
> Hi,
> 
>  I am getting BUG_ON in migration_entry_to_page() with 4.1.0-rc2
> kernel on powerpc system which has 512 CPUs (64 cores - 16 nodes) and
> 1.6 TB memory. We can easily recreate this issue with kernel compile
> (make -j500). But I could not reproduce with numa_balancing=disable.
> 

Is this patched in any way? I ask because line 134 on 4.1.0-rc2 does not
match up with a BUG_ON. It's close to a PageLocked check but I want to
be sure there are no other modifications.

Otherwise, when was the last time this worked? Was 4.0 ok? As it can be
easily reproduced, can the problem be bisected please?

-- 
Mel Gorman
SUSE Labs
