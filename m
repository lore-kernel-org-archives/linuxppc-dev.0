Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yms0G6jhQzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 18:01:50 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAT6xkUb090706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 02:01:48 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehqy08gkk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 02:01:48 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 29 Nov 2017 07:01:46 -0000
Subject: Re: [PATCH] powerpc/powernv : Add support to enable sensor groups
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1511760988-10377-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <87bmjmzla7.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 12:31:41 +0530
MIME-Version: 1.0
In-Reply-To: <87bmjmzla7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <06a771ec-fc79-0515-9166-f2a105eb33d0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 11/28/2017 05:07 PM, Michael Ellerman wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> 
>> Adds support to enable/disable a sensor group. This can be used to
>> select the sensor groups that needs to be copied to main memory by
>> OCC. Sensor groups like power, temperature, current, voltage,
>> frequency, utilization can be enabled/disabled at runtime.
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>> The skiboot patch for the opal call is posted below:
>> https://lists.ozlabs.org/pipermail/skiboot/2017-November/009713.html
> 
> Can you remind me why we're doing this with a completely bespoke sysfs
> API, rather than using some generic sensors API?
> 

Disabling/Enabling sensor groups is not supported in the current generic sensors
API. And also we dont export all type of sensors in HWMON as not all of them are
environment sensors (like performance).

> And if we must do it that way, please add documentation for the sysfs
> file(s) in Documentation/ABI/.
> 

Will do.

Thanks and Regards,
Shilpa

> cheers
> 
