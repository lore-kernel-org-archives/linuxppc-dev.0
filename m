Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C7051A1A59
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 22:52:29 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A3D701402DE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 22:52:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 18:22:26 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 904F1E005C
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:26:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PCqA5s54132768
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:22:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PBo3ID025774
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 17:20:04 +0530
Message-ID: <558BF978.5020007@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 18:22:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V9 05/13] powerpc, perf: Change name & type of 'pred'
 in power_pmu_bhrb_read
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-6-git-send-email-khandual@linux.vnet.ibm.com>
 <1435209074.4286.30.camel@axtens.net>
In-Reply-To: <1435209074.4286.30.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 10:41 AM, Daniel Axtens wrote:
>> 				cpuhw->bhrb_entries[u_index].to = addr;
>> -				cpuhw->bhrb_entries[u_index].mispred = pred;
>> -				cpuhw->bhrb_entries[u_index].predicted = ~pred;
>> +				cpuhw->bhrb_entries[u_index].mispred = mispred;
>> +				cpuhw->bhrb_entries[u_index].predicted =
>> +								~mispred;
>>  
> 
> This is much better! However, these are still bitwise rather than
> logical inversions. They will work, but would it be easier to understand
> if you used "!mispred"?

Sure, will change it as well.
