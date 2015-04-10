Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66EAB1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 20:33:46 +1000 (AEST)
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D0030140284
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 20:33:44 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Fri, 10 Apr 2015 11:33:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F411A2190063
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 11:33:22 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3AAXaCV54132892
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 10:33:36 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3AAXZ8q016994
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 06:33:36 -0400
In-Reply-To: <5527938B.1030901@linux.vnet.ibm.com>
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
Subject: Re: [V6,1/9] elf: Add new powerpc specifc core note sections
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Message-ID: <OFCDE0430E.A5CD2FAF-ONC1257E23.003813C4-C1257E23.0039F950@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Fri, 10 Apr 2015 12:33:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: shuahkh@osg.samsung.com, Michael Neuling <mikey@neuling.org>,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 peterz@infradead.org, palves@redhat.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
 kirjanov@gmail.com, tglx@linutronix.de, oleg@redhat.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 10.04.2015
11:10:35:

> I had posted a newer version [V7] of this patch series couple of months
back
> which got ignored while the discussion continued in this version.
>
> V7: https://lkml.org/lkml/2015/1/14/19

Ah, with all the back-and-forth on the checkpointed state, I never looked
at this.  Unfortunately, there's still a number of issues with this, I
think:

- You provide checkpointed FPR and VMX registers, but there doesn't seem
  to be any way to get at the checkpointed *VSX* registers (i.e. the part
  that is neither covered by FPR or VMX, corresponding to NT_PPC_VSX).

- We may have had this discussion in the past, but I still do not like the
  notion of a "misc" register set, in particular since the three registers
  in it are available at different architecture levels and categories.

  I would much prefer three separate regsets (e.g. NT_PPC_DSCR, NT_PPC_PPR,
  and NT_PPC_TAR), each of which is available and valid if and only if the
  current processor actually has the register in question.

  If we do have a single regset, at the very least a "get" operation should
  set registers unvailable on the machine to a defined state (zero?)
  instead of simply leaving memory uninitialized.

- Similarly, the NT_PPC_TM_SPR regset as currently defined mixes and
matches
  registers with different "lifetimes".  The transactional memory registers
  (TFHAR, TEXASR, TFIAR) are available *always* on machines that support
  transactions.  But the other registers in that regset are checkpointed
  versions that are only available/valid within a transaction.  I think a
  better way to faithfully represent this would be to have the
NT_PPC_TM_SPR
  regset only contain the transcational memory registers, and use separate
  regsets for the checkpointed registers -- those should parallel the non-
  checkpointed register regset.

  For example, if we have NT_PPC_DSCR, there should be a NT_PPC_CDSCR for
  the checkpointed version etc.  (If we do stay with MISC, there should
then
  be a CMISC).

- Particularly confusing to me is the "checkpointed original MSR" which
  currently also resides in NT_PPC_TM_SPR.  What exactly is this?  How
  does that differ from the MSR slot in the NT_PPC_TM_CGPR regset?

  I may be misreading kernel code, but it seems the kernel does not
actually
  use the ckpt_regs.msr slot at all, and therefore the corresponding slot
of
  the NT_PPC_TM_CGPR regset is likewise undefined/unused.  Would it not be
  more consistent to use that slot to pass the checkpointed MSR?

  In any case, it seems the ptrace set-register case currently allows user
  space to restore *any* arbitrary value into the checkpointed MSR, which
  would presumably get restored into the real MSR at some point, unless I'm
  missing something here.  Do we not need a check that only safe bits are
  modified, just like with ptrace access to the real MSR?

Bye,
Ulrich
