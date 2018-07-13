Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RnCp6RQrzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 19:13:26 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6D94vXD053730
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 05:13:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k6rvcs87j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 05:13:24 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 13 Jul 2018 03:13:23 -0600
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on powerpc
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: sachinp@linux.vnet.ibm.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Michal Hocko <mhocko@suse.com>, sim@linux.vnet.ibm.com,
 venkatb3@in.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 manvanth@linux.vnet.ibm.com, Linux Memory Management List
 <linux-mm@kvack.org>,
 linux-next@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 13 Jul 2018 14:43:11 +0530
In-Reply-To: <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
References: <1531416305.6480.24.camel@abdul.in.ibm.com>
 <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1531473191.6480.26.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-12 at 13:44 -0400, Pavel Tatashin wrote:
> > Related commit could be one of below ? I see lots of patches related to mm and could not bisect
> >
> > 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memblock_next_valid_pfn() on arm/arm64
> > 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get_free_pages-fix
> > 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __get_free_pages
> > 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ignore mempolicies for high priority allocations
> > 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block at a time in zero_resv_unresv()
> 
> Looks like:
> 0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> 
> This patch is going to be reverted from linux-next. Abdul, please
> verify that issue is gone once  you revert this patch.

kernel booted fine when the above patch is reverted.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
