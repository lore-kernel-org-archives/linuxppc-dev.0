Return-Path: <vrbagal1@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PyWl2w7tzDrWk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 20:05:54 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6AA59Ze081013
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 06:05:52 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k4sn05hyu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 06:05:51 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Tue, 10 Jul 2018 04:05:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 10 Jul 2018 15:41:21 +0530
From: vrbagal1 <vrbagal1@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, sachinp <sachinp@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linuxppc-dev
 <linuxppc-dev-bounces+vrbagal1=linux.vnet.ibm.com@lists.ozlabs.org>
Subject: Re: [powerpc/powervm]Oops: Kernel access of bad area, sig: 11 [#1]
 while running stress-ng
In-Reply-To: <20180710180708.6e0cd26b@roar.ozlabs.ibm.com>
References: <8595a4f915a7344210a8cc7ad6923a2b@linux.vnet.ibm.com>
 <20180710180708.6e0cd26b@roar.ozlabs.ibm.com>
Message-Id: <920d9bc6a2c3449700dec191c271bdff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-07-10 13:37, Nicholas Piggin wrote:
> On Tue, 10 Jul 2018 11:58:40 +0530
> vrbagal1 <vrbagal1@linux.vnet.ibm.com> wrote:
> 
>> Hi,
>> 
>> Observing kernel oops on Power9(ZZ) box, running on PowerVM, while
>> running stress-ng.
>> 
>> 
>> Kernel: 4.18.0-rc4
>> Machine: Power9 ZZ (PowerVM)
>> Test: Stress-ng
>> 
>> Attached is .config file
>> 
>> Traces:
>> 
>>   [12251.245209] Oops: Kernel access of bad area, sig: 11 [#1]
> 
> Can you post the lines above this? Otherwise we don't know what address
> it tried to access (without decoding the instructions and 
> reconstructing
> it from registers at least, which the XFS devs wouldn't be inclined to
> do).
> 

ah my bad.

  [12251.245179] Unable to handle kernel paging request for data at 
address 0x6000000060000000
  [12251.245199] Faulting instruction address: 0xc000000000319e2c


> And I assume there is nothing else relevant to XFS in the dmesg before
> this?

Nothing relevant in dmesg

Regards,
Venkat.

> 
> Thanks,
> Nick
