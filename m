Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYN5M6wy1zDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 04:40:39 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21HYeZK042509
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 12:40:37 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrb6320-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 12:40:36 -0500
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 14:40:32 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2683D1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 12:40:30 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21HeNLp35782808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 14:40:28 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21He8ll024791
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 14:40:08 -0300
Subject: Re: [RESEND-RFC v2 1/3] powerpc/eeh: Refactor
 eeh_pe_update_time_stamp() to update freeze_count
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
 <e288dd57-df0d-44c1-2867-ce1d1386ad1f@linux.vnet.ibm.com>
 <87lgsp0xpt.fsf@vajain21.in.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 14:39:53 -0300
MIME-Version: 1.0
In-Reply-To: <87lgsp0xpt.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <cffa9e2f-0a8f-f076-bff9-0d1f6efd2f8b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2017 01:26 PM, Vaibhav Jain wrote:
> 
> Thanks for reviewing the patch !!

Yw =)


> 
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>>
>> Not sure why, but many of the words in commit message are missing their
>> first letter. See, for example:
>> reeze_count,  roze,  eports,  ermanently
> Thanks for pointing this out. Will fix this in the subsequent patch
> revision.
> 
>>>  /**
>>> - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
>>> + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
>>> + * and freeze counter
>>>   * @pe: EEH PE
>>>   *
>>> - * We have time stamp for each PE to trace its time of getting
>>> - * frozen in last hour. The function should be called to update
>>> - * the time stamp on first error of the specific PE. On the other
>>> - * handle, we needn't account for errors happened in last hour.
>>
>> s/handle/hand? "On the other hand..."
> Thats part of original comment which this patch is replacing.

.....hehehe
How didn't I notice?
Sorry, my bad!
