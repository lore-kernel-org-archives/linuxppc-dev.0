Return-Path: <ulrich.weigand@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14FBE1A0DC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 02:41:15 +1000 (AEST)
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0623B1401F6
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2015 02:41:13 +1000 (AEST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Mon, 8 Jun 2015 17:41:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2F893219005C
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2015 17:40:47 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t58Gf7bn22741154
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 16:41:07 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t58Gf63c027526
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2015 10:41:07 -0600
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V8 00/28] Add new powerpc specific ELF core notes
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, avagin@openvz.org, benh@kernel.crashing.org,
 davej@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 emachado@linux.vnet.ibm.com, james.hogan@imgtec.com,
 kirjanov@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, mpe@ellerman.id.au,
 nacc@linux.vnet.ibm.com, oleg@redhat.com, palves@redhat.com,
 Paul.Clothier@imgtec.com, peterz@infradead.org,
 sam.bobroff@au1.ibm.com, shuahkh@osg.samsung.com,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de
Message-ID: <OF2F907C21.D0D51611-ONC1257E5E.005A75D4-C1257E5E.005A8916@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Mon, 8 Jun 2015 18:28:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote on 19.05.2015
17:07:56:

>    This patch series adds twelve new ELF core note sections which can
> be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for
accessing
> various transactional memory and other miscellaneous debug register sets
on
> powerpc platform.
>
> Previous versions:
> ==================
> RFC: https://lkml.org/lkml/2014/4/1/292
> V1:  https://lkml.org/lkml/2014/4/2/43
> V2:  https://lkml.org/lkml/2014/5/5/88
> V3:  https://lkml.org/lkml/2014/5/23/486
> V4:  https://lkml.org/lkml/2014/11/11/6
> V5:  https://lkml.org/lkml/2014/11/25/134
> V6:  https://lkml.org/lkml/2014/12/2/98
> V7:  https://lkml.org/lkml/2015/1/14/19
>
> Changes in V8:
> --------------
> - Split the misc register set into individual ELF core notes
> - Implemented support for VSX register set (on and off TM)
> - Implemented support for EBB register set
> - Implemented review comments on previous versions
> - Some code re-arrangements, re-writes and documentation
> - Added comprehensive list of test cases into selftests

This addresses all the issues I raised in my comments on V7.
The register set layout looks good to me now.

Thanks,
Ulrich
