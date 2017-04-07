Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w03lz5GphzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 01:44:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37FYUdE143181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 11:44:13 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29pdh8rcam-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 11:44:12 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 7 Apr 2017 09:44:11 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH V4] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
References: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
 <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
 <87lgrcgynk.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 7 Apr 2017 10:44:01 -0500
MIME-Version: 1.0
In-Reply-To: <87lgrcgynk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <947e3e42-9c9e-a7b2-dc1b-0e5ffe747168@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nits... take 'em or leave 'em...

On 04/07/2017 08:01 AM, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> And I reworded the comment the make it clearer (I think) that most users
> shouldn't need to use these, and should just use the default size:
>
> /*
>  * When MAP_HUGETLB is set bits [26:31] encode the log2 of the huge page size.

need a comma after "set".

also, "bits [26:31]" of what?

>  * A value of zero indicates that the default huge page size should be used.
>  * To use a non-default huge page size, one of these defines can be used, or the
>  * size can be encoded by hand. Note that on most systems only a subset, or
>  * possibly none, of these sizes will be available.
>  */

PC
