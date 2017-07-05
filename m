Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2RhR5WSgzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 13:49:43 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v653n24b111850
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 23:49:41 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bg4vus249-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 23:49:40 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 13:49:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v653nZZo6619492
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 13:49:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v653nQ3I030199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 13:49:26 +1000
Subject: Re: [RFC] powerpc/mm: Enable gigantic HugeTLB page support for powernv
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170704104608.22397-1-khandual@linux.vnet.ibm.com>
 <9daa97d2-b0a7-6416-c6c5-28e6dbc727ef@linux.vnet.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 09:19:33 +0530
MIME-Version: 1.0
In-Reply-To: <9daa97d2-b0a7-6416-c6c5-28e6dbc727ef@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d21b1afc-2aae-8903-557a-bfc31628422b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 09:12 AM, Aneesh Kumar K.V wrote:
> 
> 
> On Tuesday 04 July 2017 04:16 PM, Anshuman Khandual wrote:
>> All the functionality for memblock allocation during boot was
>> already present in Book3e and embeded platforms. This change
>> just moves around some code under config conditions to make
>> the function happen on powernv platforms.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> Tested lightly on both powernv and pseries platforms with two
>> 16GB pages. Will appreciate comments and suggestions on the
>> approach.
>>
>> On PowerNV while asking for 16GB pages through kernel command
>> line, we need to be careful not to starve the system of memory
>> which can make it unable to boot.
> 
> I have a patch series that does this here. How is this different ?
> 
> http://mid.gmane.org/1496327441-7368-1-git-send-email-
> aneesh.kumar@linux.vnet.ibm.com

Hmm, did not know you have attempted this before. The link does
not open for me. Could you give the subject line for the patch
series.
