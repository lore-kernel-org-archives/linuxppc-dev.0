Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sRrKV25b4zDrvZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Sep 2016 21:31:25 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u84BN9Ib088412
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Sep 2016 07:31:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 258c4tt82a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Sep 2016 07:31:23 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 4 Sep 2016 05:31:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/mm: Don't alias user region to other regions
 below PAGE_OFFSET
In-Reply-To: <20160903095413.GA868@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <87vayeqyo7.fsf@linux.vnet.ibm.com>
 <20160903095413.GA868@fergus.ozlabs.ibm.com>
Date: Sun, 04 Sep 2016 17:01:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h99vrjei.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Fri, Sep 02, 2016 at 05:52:16PM +0530, Aneesh Kumar K.V wrote:
>> 
>> Hi Paul,
>> 
>> Really nice catch. Was this found by code analysis or do we have any
>> reported issue around this ?
>
> I found it by code analysis.
>
> I haven't been able to find any really bad consequence, beyond leaking
> some information about kernel memory.  Can you find any worse
> consequence?
>

No, considering linux page table entry is not going to have a mapping
for this address.

-aneesh
