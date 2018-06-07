Return-Path: <vrbagal1@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411cYh2SY5zF32f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 17:27:04 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w577NuO9025305
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 03:27:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jeyqm9dp5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 03:27:01 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 01:27:00 -0600
Subject: Re: Fwd: [powerpc/Baremetal]Kernel OOPS while executing memory
 hotplug on Power8 baremetal
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
References: <ee45ead1d96ad05f77aec1d8d3e39c85@linux.vnet.ibm.com>
 <d5b62afc48ece5aca8d08a80871c8613dd555d17.camel@wdc.com>
From: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 12:56:53 +0530
MIME-Version: 1.0
In-Reply-To: <d5b62afc48ece5aca8d08a80871c8613dd555d17.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d011631b-c667-2628-dda8-2c87961329f0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 07 June 2018 12:46 PM, Bart Van Assche wrote:
> On Thu, 2018-06-07 at 12:38 +0530, vrbagal1 wrote:
>> Observing Kernel oops and machine reboots while executing memory hotplug
>> test case, on Power8 Baremetal machine.
>>
>> I see this is introduced some where between rc6 and 4.17.
> 
> Please provide the exact versions (git commit IDs) of the kernel versions
> you have tested.

Commit Id ---> 5037be168f

Regards,
Venkat
IBM Linux Technology Centre


> 
> Thanks,
> 
> Bart.
> 
> 
> 
> 
