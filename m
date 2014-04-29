Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E6AD141300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:37:03 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 19:37:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D99D3578060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:36:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T9aiYa54329570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:36:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T9awfj000941
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:36:59 +1000
Message-ID: <535F72B5.3000405@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 15:06:53 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 2/2] powerpc/pseries: init fault_around_order for
 pseries
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com>
 <877g686fpb.fsf@rustcorp.com.au>
In-Reply-To: <877g686fpb.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 dave.hansen@intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 29 April 2014 07:48 AM, Rusty Russell wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 2db8cc6..c87e6b6 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -74,6 +74,8 @@ int CMO_SecPSP = -1;
>>  unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K);
>>  EXPORT_SYMBOL(CMO_PageSize);
>>  
>> +extern unsigned int fault_around_order;
>> +
> 
> It's considered bad form to do this.  Put the declaration in linux/mm.h.
> 

ok. Will change it.

Thanks for review
With regards
Maddy

> Thanks,
> Rusty.
> PS.  But we're getting there! :)
> 
