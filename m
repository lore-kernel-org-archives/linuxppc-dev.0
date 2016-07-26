Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz77n3QsHzDqwM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:12:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q69Aif016404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:12:19 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24dnc5rac0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:12:18 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 16:12:15 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C3E192CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:12:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q6CCOZ3342582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:12:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q6CB2h023824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:12:12 +1000
Subject: Re: [RFC PATCH 6/9] powerpc: modify __SOFTEN_TEST to support
 tri-state soft_enabled flag
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-7-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726154115.292349df@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 11:42:09 +0530
MIME-Version: 1.0
In-Reply-To: <20160726154115.292349df@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b1f2b5dd-c002-420c-f90b-0ac1356f6c8b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 11:11 AM, Nicholas Piggin wrote:
> On Mon, 25 Jul 2016 20:22:19 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Foundation patch to support checking of new flag for
>> "paca->soft_enabled". Modify the condition checking for the
>> "soft_enabled" from "equal" to "greater than or equal to".
> Rather than a "tri-state" and the mystery "2" state, can you
> make a #define for that guy, and use levels.

Yes. Will do. Will wait for any feedback on the macro name
for the patch 1 of this series.

Maddy

> 0-> all enabled
> 1-> "linux" interrupts disabled
> 2-> PMU also disabled
> etc.
>
> Thanks,
> Nick
>
