Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D74482C15DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 17:11:10 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 4 Apr 2013 16:09:03 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EEB492CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 17:11:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r345vmvL43843792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 16:57:48 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r346B7dU003112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Apr 2013 17:11:07 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Simon Jeons <simon.jeons@gmail.com>
Subject: Re: [PATCH -V5 00/25] THP support for PPC64
In-Reply-To: <515D16E4.8020207@gmail.com>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <515D16E4.8020207@gmail.com>
Date: Thu, 04 Apr 2013 11:40:54 +0530
Message-ID: <87bo9u4yhd.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simon Jeons <simon.jeons@gmail.com> writes:

> Hi Aneesh,
> On 04/04/2013 01:57 PM, Aneesh Kumar K.V wrote:
>> Hi,
>>
>> This patchset adds transparent hugepage support for PPC64.
>>
>> TODO:
>> * hash preload support in update_mmu_cache_pmd (we don't do that for hugetlb)
>>
>> Some numbers:
>>
>> The latency measurements code from Anton  found at
>> http://ozlabs.org/~anton/junkcode/latency2001.c
>
> Is there test case against x86?
>

That test should work even with x86

-aneesh
