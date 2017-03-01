Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYLTX6Vf8zDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 03:28:00 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21GNv77103154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 11:27:58 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28x140aj7s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 11:27:58 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 2 Mar 2017 02:27:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A6F913578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 03:27:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21GRjIf50921712
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 03:27:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21GRL7X003858
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 03:27:21 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [RESEND-RFC v2 1/3] powerpc/eeh: Refactor
 eeh_pe_update_time_stamp() to update freeze_count
In-Reply-To: <e288dd57-df0d-44c1-2867-ce1d1386ad1f@linux.vnet.ibm.com>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
 <e288dd57-df0d-44c1-2867-ce1d1386ad1f@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 21:56:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgsp0xpt.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks for reviewing the patch !!

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>
> Not sure why, but many of the words in commit message are missing their
> first letter. See, for example:
> reeze_count,  roze,  eports,  ermanently
Thanks for pointing this out. Will fix this in the subsequent patch
revision.

>>  /**
>> - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
>> + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
>> + * and freeze counter
>>   * @pe: EEH PE
>>   *
>> - * We have time stamp for each PE to trace its time of getting
>> - * frozen in last hour. The function should be called to update
>> - * the time stamp on first error of the specific PE. On the other
>> - * handle, we needn't account for errors happened in last hour.
>
> s/handle/hand? "On the other hand..."
Thats part of original comment which this patch is replacing.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
