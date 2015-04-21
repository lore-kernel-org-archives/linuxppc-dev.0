Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8140C1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 14:56:34 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 562F91401F6
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 14:56:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 14:56:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9159E2CE804E
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 14:56:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3L4uJDg28573938
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 14:56:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3L4trZQ001893
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 14:55:54 +1000
Message-ID: <5535D83C.1060302@linux.vnet.ibm.com>
Date: Tue, 21 Apr 2015 10:25:24 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
References: <20141203052204.9DA8F1400DD@ozlabs.org>
 <54947C64.4030206@linux.vnet.ibm.com> <54A50094.5070902@linux.vnet.ibm.com>
 <1421883597.30744.3.camel@neuling.org>
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
 <5527938B.1030901@linux.vnet.ibm.com> <552B82F9.3080108@linux.vnet.ibm.com>
 <OF939465E0.3429202B-ONC1257E2D.0043E1D3-C1257E2D.004479F6@de.ibm.com>
In-Reply-To: <OF939465E0.3429202B-ONC1257E2D.0043E1D3-C1257E2D.004479F6@de.ibm.com>
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

On 04/20/2015 05:57 PM, Ulrich Weigand wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 13.04.2015
> 10:48:57:
>> On 04/10/2015 04:03 PM, Ulrich Weigand wrote:
>>> - You provide checkpointed FPR and VMX registers, but there doesn't
> seem
>>>   to be any way to get at the checkpointed *VSX* registers (i.e. the
> part
>>>   that is neither covered by FPR or VMX, corresponding to NT_PPC_VSX).
>>
>> Will change vsr_get, vsr_set functions as we have done for fpr_get and
> fpr_set
>> functions. Also will add one more ELF core note NT_PPC_TM_CVSX to fetch
> the
>> check pointed state of VSX register while inside the transaction.
> 
> OK.
> 
>>>   I would much prefer three separate regsets (e.g. NT_PPC_DSCR,
> NT_PPC_PPR,
>>>   and NT_PPC_TAR), each of which is available and valid if and only if
> the
>>>   current processor actually has the register in question.
>>
>> Thats like adding one ELF core note for every single register
>> because we cannot
>> put them in any category. Then as Michael Ellerman had pointed out to
> include
>> a lot more registers in this MISC category (which we are not doing right
> now
>> in the interest of having minimum support available before we look at the
> full
>> possible list of MISC registers), we should add one ELF core note section
> for
>> each of those individual registers ? I am not sure.
> 
> This confuses me a bit.  My understanding was that ptrace regsets, once
> defined, should never change in the future.  (GDB will only check whether
> or not a regset is supported; if it is, it will expect the contents to be
> as it expects them to be.)  "Including a lot more registers" would
> therefore
> seem to require adding new regsets anyway, which is one of the reasons why
> I disagree a "MISC" regset is particularly useful.

Yeah right. Started thinking that (NT_PPC_TAR, NT_PPC_CTAR),
(NT_PPC_PPR, NT_PPC_CPPR), (NT_PPC_DSCR, NT_PPC_CDSCR) kind of combinations
make more sense !

> 
>>> - Similarly, the NT_PPC_TM_SPR regset as currently defined mixes and
>>> matches
>>>   registers with different "lifetimes".  The transactional memory
> registers
>>>   (TFHAR, TEXASR, TFIAR) are available *always* on machines that
> support
>>>   transactions.  But the other registers in that regset are
> checkpointed
>>>   versions that are only available/valid within a transaction.  I think
> a
>>>   better way to faithfully represent this would be to have the
>>> NT_PPC_TM_SPR
>>>   regset only contain the transcational memory registers, and use
> separate
>>>   regsets for the checkpointed registers -- those should parallel the
> non-
>>>   checkpointed register regset.
>>
>> Right now, we support NT_PPC_TM_SPR only inside the transaction, so we
> dont
>> have the problem with different "lifetimes" registers accessed together.
> But
>> yes, I get your point.
> 
> Since the transactional SPRs are accessible from user space outside of a
> transaction, it would make sense for them to accessible from ptrace as
> well.
> If the current patch set doesn't do that, I guess it would be better to
> change that.

Yeah I agree. Will change it.

> 
>>> - Particularly confusing to me is the "checkpointed original MSR" which
>>>   currently also resides in NT_PPC_TM_SPR.  What exactly is this?  How
>>>   does that differ from the MSR slot in the NT_PPC_TM_CGPR regset?
>>
>> I believed it stores the check pointed MSR value which was in the
> register
>> before the transaction started. But then how it is different from the
>> ckpt_regs.msr, I am not sure. Mikey or Michael should be able to clarify
>> more on this. I can see "orig_msr" getting used in many places to hold
> the
>> check pointed value of MSR.
> 
> Your other mail states that the orig_mst may be irrelevant for ptrace
> anyway ... that would be OK with me as well.

Yeah. The variable tm_orig_msr is used to compute MSR state inside
the kernel or what would be passed to the user space while returning
at various stages of the transaction, where as ckpt_regs.msr contains
the latest check pointed MSR value to be fetched by ptrace. Thats my
understanding as of now.

> 
>>>   In any case, it seems the ptrace set-register case currently allows
> user
>>>   space to restore *any* arbitrary value into the checkpointed MSR,
> which
>>>   would presumably get restored into the real MSR at some point, unless
> I'm
>>>   missing something here.  Do we not need a check that only safe bits
> are
>>>   modified, just like with ptrace access to the real MSR?
>>
>> Where and which safe bits do we check before writing any value into the
> MSR
>> register from ptrace interface ? May be I am missing something here.
> 
> All ptrace accesses to *set* the regular msr go via this routine:
> 
> static int set_user_msr(struct task_struct *task, unsigned long msr)
> {
>         task->thread.regs->msr &= ~MSR_DEBUGCHANGE;
>         task->thread.regs->msr |= msr & MSR_DEBUGCHANGE;
>         return 0;
> }
> 
> I think we'd need to do the equivalent whenever changing the checkpointed
> MSR.

Agree, will incorporate this change.

In summary, after putting together all the issues that we have
discussed till now regarding the number and scope of all new ELF
core note sections being added, the probable elements there in
can be listed as below.

Changed ELF core note sections
------------------------------
These core note sections need to be changed to accommodate the in
transaction ptrace requests when the running/current value of these
registers will reside some where else instead of the original places
of thread_struct.

/* Running register state */
(1) NT_PRFPREG				(Accessible always)
(2) NT_PPC_VMX				(Accessible always)
(3) NT_PPC_VSX				(Accessible always)

New ELF core note sections
--------------------------
/* TM check pointed register set */
(1) NT_PPC_TM_CGPR	--> NT_PRSTATUS	(Accessible inside TM)	
(2) NT_PPC_TM_CFPR	--> NT_PRFPREG	(Accessible inside TM)
(3) NT_PPC_TM_CVMX	--> NT_PPC_VMX	(Accessible inside TM)
(4) NT_PPC_TM_CVSX	--> NT_PPC_VSX	(Accessible inside TM)

NOTE: The register set data structure for these ELF core not
sections would exactly match with that of the corresponding
running value register sets indicated above.

/* TM SPR set */			(Accessible always)
(5) NT_PPC_TM_SPR	thread->tm_tfhar
			thread->tm_tfiar
			thread->ttm_exasr

/* TM check pointed misc register set */
(6) NT_PPC_TM_TAR	thread->tm_tar	(Accessible inside TM)
(7) NT_PPC_TM_PPR	thread->tm_ppr	(Accessible inside TM)
(8) NT_PPC_TM_DSCR	thread->tm_dscr (Accessible inside TM)

NOTE: Application can have a different set of TAR, PPR and DSCR
registers inside the transaction compared that of the outside.
Also seems like they are *not* the check pointed ones, will
double check on this. Changed the core note section name from
NT_PPC_TM_CTAR to just NT_PPC_TM_TAR and for all the others.

/* Running misc register set */
(9) 	NT_PPC_TAR	thread->tar	(Accessible always)
(10)	NT_PPC_PPR	thread->ppr	(Accessible always)
(11)	NT_PPC_DSCR	thread->dscr	(Accessible always)

NOTE: They are like any other special purpose register which can
be changed from the user space. So the elf core note section name
can be generic. Here are some optional ELF core note sections
which we can also add like the above ones.

(12)	NT_PPC_EBBRR	thread->ebbrr	(Accessible inside EBB)
(13)	NT_PPC_EBBHR	thread->ebbhr	(Accessible inside EBB)
(14)	NT_PPC_BESCR	thread->bescr	(Accessible inside EBB)
(15)	NT_PPC_SIAR	thread->siar	(Accessible inside EBB)
(16) 	NT_PPC_SDAR	thread->sdar	(Accessible inside EBB)
(17)	NT_PPC_SIER	thread->sier	(Accessible inside EBB)
(18)	NT_PPC_MMCR2	thread->mmcr2	(Accessible inside EBB)
(19)	NT_PPC_MMCR0	thread->mmcr0	(Accessible inside EBB)

Ulrich, Mikey, MPE,

	Please do let me know your thoughts on this.

Regards
Anshuman
