Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425g5q1kHVzF3HT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 22:35:43 +1000 (AEST)
Date: Thu, 6 Sep 2018 14:35:39 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mpe@ellerman.id.au, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 1/4] mm: Export alloc_migrate_huge_page
Message-ID: <20180906123539.GV14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906123111.GC26069@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906123111.GC26069@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 06-09-18 14:31:11, Michal Hocko wrote:
> On Thu 06-09-18 11:13:39, Aneesh Kumar K.V wrote:
> > We want to use this to support customized huge page migration.
> 
> Please be much more specific. Ideally including the user. Btw. why do
> you want to skip the hugetlb pools? In other words alloc_huge_page_node*
> which are intended to an external use?

Ups, I have now found http://lkml.kernel.org/r/20180906054342.25094-2-aneesh.kumar@linux.ibm.com
which ended up in a different email folder so I have missed it. It would
be much better to merge those two to make the user immediately obvious.
There is a good reason to keep newly added functions closer to their
users.
-- 
Michal Hocko
SUSE Labs
