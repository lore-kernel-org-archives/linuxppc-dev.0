Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 712F91A065E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 18:40:22 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB0B71402B7
 for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2015 18:40:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 25 May 2015 14:10:19 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 696D11258053
 for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2015 14:12:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4P8eFwP48758896
 for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2015 14:10:15 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4P8eD85020964
 for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2015 14:10:15 +0530
Message-ID: <5562DFEC.7090805@linux.vnet.ibm.com>
Date: Mon, 25 May 2015 14:10:12 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
CC: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com,
 emachado@linux.vnet.ibm.com, oleg@redhat.com, davem@davemloft.net,
 dhowells@redhat.com, Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com,
 davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH V8 00/28] Add new powerpc specific ELF core notes
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2015 08:37 PM, Anshuman Khandual wrote:
> From: Anshuman Khandual <anshuman@localhost.localdomain>
> 
> 	This patch series adds twelve new ELF core note sections which can
> be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for accessing
> various transactional memory and other miscellaneous debug register sets on
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


These patches are available for pull from this location mentioned below.

https://github.com/akhandual/linux.git ptrace_powerpc_v8
