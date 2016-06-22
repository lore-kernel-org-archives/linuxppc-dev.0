Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZR8K2mtVzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:01:04 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDxRpx046762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:01:01 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q795qr17-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:01:01 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 15:01:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 69CC81B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:02:09 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5ME0vCg6095166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 14:00:57 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5ME0ulb013567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:00:57 -0400
Date: Wed, 22 Jun 2016 16:02:33 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, mikey <mikey@neuling.org>,
 manoj <manoj@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [v6, 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
 <87k2hkgs6v.fsf@vajain21.in.ibm.com>
 <1466483778-sup-4320@x230.ozlabs.ibm.com>
 <87eg7qg79t.fsf@vajain21.in.ibm.com>
 <2686A514-2808-4F08-8514-5E08B5D3608A@linux.vnet.ibm.com>
In-Reply-To: <2686A514-2808-4F08-8514-5E08B5D3608A@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <576A9A79.6050101@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matthew R. Ochs wrote:
>>On Jun 21, 2016, at 5:34 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:
>>
>>Hi Ian,
>>
>>Ian Munsie <imunsie@au1.ibm.com> writes:
>>
>>
>>>Excerpts from Vaibhav Jain's message of 2016-06-20 14:20:16 +0530:
>>>
>>>What exactly is the use case for this API? I'd vote to drop it if we can
>>>do without it.
>>
>>Agree with this. Functionality of this API can be merged with
>>cxl_set_driver_ops when called with NULL arg for cxl_afu_driver_ops.
> 
> 
> Passing a NULL arg instead of calling an 'unset' API is fine with us.
> 
> I'll add that for cxlflash, I can't envision a scenario where we'll unset the
> driver ops for a context.
> 
Agreed, thanks. I will drop API cxl_unset_driver_ops() in v7.

Philippe
