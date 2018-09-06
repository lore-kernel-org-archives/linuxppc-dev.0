Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425hMH2t1KzF3Rm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 23:32:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w86DUBfK142063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2018 09:32:25 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mb3jw4uy1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2018 09:32:24 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 6 Sep 2018 07:32:24 -0600
Subject: Re: [RFC PATCH V2 1/4] mm: Export alloc_migrate_huge_page
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906123111.GC26069@dhcp22.suse.cz>
 <20180906123539.GV14951@dhcp22.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 6 Sep 2018 19:02:16 +0530
MIME-Version: 1.0
In-Reply-To: <20180906123539.GV14951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <50682adc-5be9-1fac-fd84-abc6bbea7549@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/06/2018 06:05 PM, Michal Hocko wrote:
> On Thu 06-09-18 14:31:11, Michal Hocko wrote:
>> On Thu 06-09-18 11:13:39, Aneesh Kumar K.V wrote:
>>> We want to use this to support customized huge page migration.
>>
>> Please be much more specific. Ideally including the user. Btw. why do
>> you want to skip the hugetlb pools? In other words alloc_huge_page_node*
>> which are intended to an external use?
> 
> Ups, I have now found http://lkml.kernel.org/r/20180906054342.25094-2-aneesh.kumar@linux.ibm.com
> which ended up in a different email folder so I have missed it. It would
> be much better to merge those two to make the user immediately obvious.
> There is a good reason to keep newly added functions closer to their
> users.
> 

It is the same series. I will fold the patch 1 and 2.

-aneesh
