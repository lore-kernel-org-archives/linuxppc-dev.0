Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNTB53hdQzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 18:58:05 +1000 (AEST)
Received: from mx0b-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rNTB50kB5z9sdm
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jun 2016 18:58:02 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u568nZvn009460
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jun 2016 04:58:00 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23bt1pwdch-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Jun 2016 04:57:59 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Jun 2016 18:57:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C0B683578052
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jun 2016 18:57:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u568viwC13304158
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jun 2016 18:57:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u568vL6F026486
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jun 2016 18:57:23 +1000
Date: Mon, 06 Jun 2016 14:27:11 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>
CC: Paul.Clothier@imgtec.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 shuahkh@osg.samsung.com, kirjanov@gmail.com,
 sukadev@linux.vnet.ibm.com, james.hogan@imgtec.com,
 Ulrich.Weigand@de.ibm.com, davej@redhat.com, tglx@linutronix.de,
 avagin@openvz.org, palves@redhat.com, oleg@redhat.com,
 davem@davemloft.net, Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 emachado@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com> <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com> <5748004F.7040408@linux.vnet.ibm.com>
 <1464649951.16938.5.camel@ellerman.id.au>
 <201606010827.u518O0bl023243@mx0a-001b2d01.pphosted.com>
 <CAN-ccASsMPA2=rXnCQaDnnzYAFqkMACVyrM-Oz=OH76-SbogCw@mail.gmail.com>
In-Reply-To: <CAN-ccASsMPA2=rXnCQaDnnzYAFqkMACVyrM-Oz=OH76-SbogCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <57553AE7.3060704@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2016 03:56 AM, Cyril Bur wrote:
> On 1 June 2016 at 18:26, Anshuman Khandual <khandual@linux.vnet.ibm.com>
> wrote:
> 
>> On 05/31/2016 04:42 AM, Michael Ellerman wrote:
>>> Hi Laurent,
>>>
>>> Sorry no. My next branch closed for 4.7 about 3 weeks ago.
>>>
>>> This series has been blocked for a long time on the gdb support, but
>> that is
>>> now working. However it still doesn't pass its own selftests, and I had
>> some
>>
>> This series was clearing all of the selftests at the time it was posted.
>> But yes, it has some assumptions from timing and sync perspective which
>> gets broken some times as the kernel changes. Its been bit difficult to
>> perfect the sync requirements as we can do only some much inside the
>> transaction once it gets started. There are scopes here to improve these
>> selftests but not clearing them today does not really mean the patches are
>> now functionally broken.
>>
>>> disagreements with the implementation - it duplicates a lot of code
>> rather
>>> than refactoring things.
>>
>> hmm, sorry, I dont remember the context here. Can you please point to the
>> discussion in this regard ?
>>
>>>
>>> I'm waiting on a patch from Cyril which will rework how the TM FP state
>> is
>>> handled, and that should make this series easier to implement.
>>
>> Can you please elaborate on this ? Has this patch been posted in the
>> mailing
>> list ? How does this make it easier for us to implement these ELF notes ?
> 
> 
> Hi Anshuman,
> 
> I'm doing a bit of a rewrite of the TM handling of the FP/VMX/VSX state.
> 
> At the moment is is rather confusing since pt_regs is the always the 'live'
> state
> and theres a ckpt_regs that is the pt_regs for the checkpointed state.
> FPU/VMX/VSX
> is done differently which is really only creating confusion so I'm changing
> it to do the
> same at for pt_regs/ckpt_regs. Ultimately this is part of more work from me

But that changes the basic semantics on which this ptrace series is written.
With this change, a significant part of the ptrace series has to be changed.
Its just an improvement on how we store running and check pointed values for
FP/VSX/VMX registers inside the kernel. How does it improve ptrace interface
from the user point of view ? If not, then why this change is necessary for
the acceptance of this patch series ? This change should be implemented as
an independent work and then necessary ptrace change can be incorporated
there after.

> but
> Michael has told me that at least this bit is useful now so I'm splitting
> it off from
> the bigger picture and sending asap. At the very least it will make it
> easier to know
> what and where the transactional state it and where the checkpointed state
> is.
> 
> It isn't on the list but I hope I'll get it out today.
