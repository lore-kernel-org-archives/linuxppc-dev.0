Return-Path: <ricklind@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w488m6jl6zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 17:16:24 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3E7DoQA014844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 03:16:19 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t32rxub3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 03:16:18 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ricklind@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 03:16:18 -0400
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
To: kbuild test robot <lkp@intel.com>
References: <201704132333.lhqnK0L3%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 00:16:12 -0700
MIME-Version: 1.0
In-Reply-To: <201704132333.lhqnK0L3%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3371c437-75c9-1aa0-5d60-02ff1a2f07bb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2017 08:35 AM, kbuild test robot wrote:
> Hi Rick,
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on next-20170413]
> [cannot apply to v4.11-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Bah. I encountered this during a backport and typoed the structure name in preparing the patch here.  All the references to addr_limit should have been context.addr_limit.

However, Aneesh's post https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/156781.html makes this one unnecessary. With that patch, the two branches, radix and hash, are congruent in their treatment of addr_limit.

Rick
