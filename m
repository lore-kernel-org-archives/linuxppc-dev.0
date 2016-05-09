Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3Mmd5rgMzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 22:55:13 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r3Mmd17mMz9t3k
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 22:55:12 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 9 May 2016 18:25:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5D421125805C
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 18:27:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u49CtEKM21954966
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 18:25:14 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u49Csxo6009469
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 18:25:05 +0530
Message-ID: <5730889F.5030501@linux.vnet.ibm.com>
Date: Mon, 09 May 2016 18:24:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462535365.13173.1.camel@ellerman.id.au>
In-Reply-To: <1462535365.13173.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2016 05:19 PM, Michael Ellerman wrote:
> On Tue, 2016-02-16 at 14:29 +0530, Anshuman Khandual wrote:
> 
>> > 	This patch series adds twelve new ELF core note sections which can
>> > be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for accessing
>> > various transactional memory and other miscellaneous debug register sets on
>> > powerpc platform.
>> > 
>> > Test Result (All tests pass on both BE and LE)
>> > ----------------------------------------------
>> > ptrace-ebb		PASS
>> > ptrace-gpr		PASS
>> > ptrace-tm-gpr		PASS
>> > ptrace-tm-spd-gpr	PASS
>> > ptrace-tar		PASS
>> > ptrace-tm-tar		PASS
>> > ptrace-tm-spd-tar	PASS
>> > ptrace-vsx		PASS
>> > ptrace-tm-vsx		PASS
>> > ptrace-tm-spd-vsx	PASS
>> > ptrace-tm-spr		PASS
> How are you building the tests? On BE I get:

Yeah, it fails to compile on 32 bit BE. Will make it explicit -m64 next time around.
