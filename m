Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07E41A1A35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 16:43:40 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DD9D1400B7
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 16:43:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 20 Apr 2015 16:43:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0B787357804C
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 16:43:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3K6hSRg22151288
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 16:43:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3K6h1xI015129
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 16:43:03 +1000
Message-ID: <55349FD9.5040006@linux.vnet.ibm.com>
Date: Mon, 20 Apr 2015 12:12:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <548578A8.5020901@linux.vnet.ibm.com> <54947C64.4030206@linux.vnet.ibm.com>
 <54A50094.5070902@linux.vnet.ibm.com> <1421883597.30744.3.camel@neuling.org>
 <OFC6CFC348.C619B89D-ONC1257DD5.0056279B-C1257DD5.00577002@de.ibm.com>
 <1421963049.30744.23.camel@neuling.org>
 <1422419289.9646.20.camel@neuling.org>
 <OFE5516C3F.3C4884DE-ONC1257DE4.004E7852-C1257DE4.00514232@de.ibm.com>
 <1424667110.16027.6.camel@neuling.org>
 <OF5DE08D4B.0B79C501-ONC1257E0C.0044F80B-C1257E0C.0046DC8F@de.ibm.com>
 <1426718702.4866.2.camel@neuling.org> <1426719027.4866.4.camel@neuling.org>
 <550FEC36.8080803@linux.vnet.ibm.com>
 <OF91038A37.65C405E5-ONC1257E21.0061938F-C1257E21.00620A03@de.ibm.com>
 <1428534695.4682.18.camel@neuling.org> <55267595.90
 <5527938B.1030901@linux.vnet.ibm.com>
 <OFCDE0430E.A5CD2FAF-ONC1257E23.003813C4-C1257E23.0039F950@de.ibm.com>
 <552B82F9.3080108@linux.vnet.ibm.com>
In-Reply-To: <552B82F9.3080108@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 shuahkh@osg.samsung.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, davem@davemloft.net, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2015 02:18 PM, Anshuman Khandual wrote:
> On 04/10/2015 04:03 PM, Ulrich Weigand wrote:
>> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 10.04.2015
>> 11:10:35:
> 
> I believed it stores the check pointed MSR value which was in the register
> before the transaction started. But then how it is different from the
> ckpt_regs.msr, I am not sure. Mikey or Michael should be able to clarify
> more on this. I can see "orig_msr" getting used in many places to hold the
> check pointed value of MSR.

tm_orig_msr is used during process context switch only. ckpt_regs
gets used in the signal context where we save all userspace context.
So ptrace would look into the saved MSR value correctly inside
ckpt_regs.msr slot. I believe thats the check pointed MSR value
we are interested in from the ptrace perspective not the tm_orig_msr
which just gets used during process context switch.


>>   I may be misreading kernel code, but it seems the kernel does not
>> actually
>>   use the ckpt_regs.msr slot at all, and therefore the corresponding slot
>> of
>>   the NT_PPC_TM_CGPR regset is likewise undefined/unused.  Would it not be
>>   more consistent to use that slot to pass the checkpointed MSR?
> 
> Hmm. Its a valid point. Would like to get some more clarity on this from
> Mikey whether that slot can be used for check pointed MSR value or not.
> Then why did we have these two slots to hold the same check pointed MSR
> value in the first place at all. Getting confused a bit.

Using ckpt_regs.msr during process context switch instead of tm_orig_msr seems
to be working fine and all the basic TM tests pass, in which case we can drop
tm_orig_msr from thread_struct. Will post a patch on this and see whats the
response from others.
