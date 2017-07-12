Return-Path: <srs0=/ati=6p=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x700X3HhdzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 23:19:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x700X2Z4fz8t6d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 23:19:24 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x700W6pWHz9s74
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 23:19:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6CCDZqE080188
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 08:15:16 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj8g1j2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 08:15:16 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 12 Jul 2017 22:15:14 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6CCFCk326476738
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 22:15:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6CCFA0e028264
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 22:15:10 +1000
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
To: msuchanek <msuchanek@suse.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
 <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
 <20170512174209.67ccfd45@kitsune.suse.cz>
 <b6a968fe-378e-1273-a996-43c716f276bd@linux.vnet.ibm.com>
 <20170515112901.67d32e76@kitsune.suse.cz>
 <102276aa-cddb-dc60-269c-b29dedc89eab@linux.vnet.ibm.com>
 <20170609140454.2eb01371@kitsune.suse.cz>
 <a3ac4a10-3315-187b-e29a-01637ba19dff@linux.vnet.ibm.com>
 <20170626141501.6086b6ab@kitsune.suse.cz>
 <dc6ce480-52e0-1cf9-a2ce-252fdf24f79a@linux.vnet.ibm.com>
 <20170712133102.2145e393@naga>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 17:45:07 +0530
MIME-Version: 1.0
In-Reply-To: <20170712133102.2145e393@naga>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d2f8bc2f-5e5f-436b-b9fc-5912af7c7ab7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 12 July 2017 05:01 PM, msuchanek wrote:
> Hello,
>
> On Wed, 12 Jul 2017 00:00:57 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hi Michal,
>>
>>
>> Thanks for the review..
>>
>>
>> On Monday 26 June 2017 05:45 PM, Michal Suchánek wrote:
>>> Hello,
>>>
>>> On Tue, 20 Jun 2017 21:14:08 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>   
>> I would prefer documenting over a complex implementation. Actually, I
>> am considering a simple approach of replacing every occurrence of
>> "fadump_extra_args=" with "fadump_extra_args " in fadump capture
>> kernel. The cmdline
>>
>>     "root=/dev/sda2 ro fadump_extra_args="a b c" crashkernel=512M
>> fadump_extra_args=d"
>>
>> becomes
>>
>>     "root=/dev/sda2 ro fadump_extra_args "a b c" crashkernel=512M
>> fadump_extra_args d"
> which is totally broken

My bad! I don't know what I was thinking when I expected that to work.. :-[

>> in fadump capture kernel. This must take care of the pitfalls with
>> the current approach and also,
>> doesn't rely on parse_args() which was not designed for this scenario
>> to start with..?
> It was designed for parsing arguments. To handle replacing arguments
> you have to extend it. You need to get more information from it for
> this case.

I will try to work on this. Also, want to replace in-place without 
moving other parameters.
I guess, I could do that by replacing the leftover length after 
processing with spaces..

Thanks
Hari
