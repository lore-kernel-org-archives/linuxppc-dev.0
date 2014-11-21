Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9E931A09F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 21:27:05 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7863E140187
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 21:27:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 21 Nov 2014 20:27:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 627AE2BB0066
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 21:27:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sALAR1xm30343402
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 21:27:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sALAQxab007994
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 21:27:01 +1100
Message-ID: <546F1367.4060301@linux.vnet.ibm.com>
Date: Fri, 21 Nov 2014 15:56:47 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Denis Kirjanov <kirjanov@gmail.com>
Subject: Re: [PATCH V4 7/8] powerpc, ptrace: Enable support for miscellaneous
 debug registers
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-8-git-send-email-khandual@linux.vnet.ibm.com>
 <54647DA7.1070000@linux.vnet.ibm.com>
 <CAHj3AVna2H1VZvP0=Xjw9pqS+gRKR7_KH9FNhX3vUBFh7OU2wA@mail.gmail.com>
In-Reply-To: <CAHj3AVna2H1VZvP0=Xjw9pqS+gRKR7_KH9FNhX3vUBFh7OU2wA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, davem@davemloft.net, peterz@infradead.org,
 palves@redhat.com, linux-kernel@vger.kernel.org, oleg@redhat.com,
 dhowells@redhat.com, linuxppc-dev@ozlabs.org, davej@redhat.com,
 tglx@linutronix.de, sukadev@linux.vnet.ibm.com, akpm@linux-foundation.org,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/14/2014 03:30 PM, Denis Kirjanov wrote:
> On 11/13/14, Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
>> > On 11/11/2014 10:56 AM, Anshuman Khandual wrote:
>>> >> This patch enables get and set of miscellaneous debug registers through
>>> >> ptrace PTRACE_GETREGSET-PTRACE_SETREGSET interface by implementing new
>>> >> powerpc specific register set REGSET_MISC support corresponding to the
>>> >> new ELF core note NT_PPC_MISC added previously in this regard.
>> >
>> > Right now this one does not compile for "ppc64e_defconfig" and
>> > "pmac32_defconfig" config options. The patch below will fix it
>> > and would be part of next revision.
> It would be great to have a test tool for that under
> tools/testing/selftests/ptrace/
> 

Hey Denis,

I have already added one test case under selftests/powerpc/tm/ which
will test all the newly added ELF core note based ptrace requests on
powerpc. This test case is added as part of the next patch 8/8 in
the series. Please let me know if the test case does not cover something
you are looking for.  
