Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4JQd2yPCzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 23:28:57 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3EDSD37098887
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 09:28:52 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29tp3e2fsw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 09:28:51 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 14 Apr 2017 18:58:48 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3EDSkoK6488308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 18:58:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3EDSj4l018777
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 18:58:46 +0530
Subject: Re: [PATCH] selftests/powerpc/mm: Add a test for virtual address
 mapping
To: linuxppc-dev@lists.ozlabs.org
References: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 14 Apr 2017 18:58:44 +0530
MIME-Version: 1.0
In-Reply-To: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <fb110fed-60f0-858c-af74-9b59672262f8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/12/2017 03:11 PM, Anshuman Khandual wrote:
> This verifies virtual address mapping below and above the
> 128TB range and makes sure that address returned are within
> the expected range depending upon the hint passed from the
> user space.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Tested this on latest ppc-next with Aneesh's yesterday's patch
> which can be found at https://patchwork.ozlabs.org/patch/749510/

Hello Aneesh/Michael,

Does this look okay as a small singular test for below and above
the 128TB range allocations ? Or do you think some thing else needs
to be added here as well.

Regards
Anshuman
