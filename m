Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp08.blacknight.com (outbound-smtp08.blacknight.com
 [46.22.139.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5HSB1y1SzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:47:53 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
 by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id
 950471C1AE5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 07:47:49 +0100 (IST)
Date: Fri, 5 Aug 2016 07:47:47 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH V2 1/2] mm/page_alloc: Replace set_dma_reserve to
 set_memory_reserve
Message-ID: <20160805064747.GN2799@techsingularity.net>
References: <1470330729-6273-1-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1470330729-6273-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 10:42:08PM +0530, Srikar Dronamraju wrote:
> Expand the scope of the existing dma_reserve to accommodate other memory
> reserves too. Accordingly rename variable dma_reserve to
> nr_memory_reserve.
> 
> set_memory_reserve also takes a new parameter that helps to identify if
> the current value needs to be incremented.
> 

I think the parameter is ugly and it should have been just
inc_memory_reserve but at least it works.

-- 
Mel Gorman
SUSE Labs
