Return-Path: <eranian@google.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4F92C00BF
 for <linuxppc-dev@ozlabs.org>; Tue, 21 May 2013 23:46:44 +1000 (EST)
Received: by mail-ob0-f182.google.com with SMTP id va2so713469obc.41
 for <linuxppc-dev@ozlabs.org>; Tue, 21 May 2013 06:46:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130521085010.GB26912@twins.programming.kicks-ass.net>
References: <20130503121122.931661809@chello.nl>
 <20130503121256.230745028@chello.nl>
 <CABPqkBTvcQAyXfeiJwpPsNtbs4ffsVguXE631dK_rbzHpwBdOg@mail.gmail.com>
 <20130516090916.GF19669@dyad.programming.kicks-ass.net>
 <8578.1368699317@ale.ozlabs.ibm.com>
 <20130516111634.GA15314@twins.programming.kicks-ass.net>
 <CABPqkBSCXJN7gLK_e_Q3YVVVFVGS78fo4j2z0+MmriqoXszH+w@mail.gmail.com>
 <20130517111232.GE5162@dyad.programming.kicks-ass.net>
 <10224.1369114895@ale.ozlabs.ibm.com>
 <20130521085010.GB26912@twins.programming.kicks-ass.net>
Date: Tue, 21 May 2013 15:46:42 +0200
Message-ID: <CABPqkBTX9HkeoQ3YAduG8C=Vyy=74Av2ZORMKAo6T9aERmR93w@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf, x86,
 lbr: Demand proper privileges for PERF_SAMPLE_BRANCH_KERNEL
From: Stephane Eranian <eranian@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 21, 2013 at 10:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 21, 2013 at 03:41:35PM +1000, Michael Neuling wrote:
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Can we add your signed-off-by on this?
>>
>> We are cleaning up our series for conditional branches and would like to
>> add this as part of the post.
>
> Sure, but its completely untested.. I was hoping Stephane would say
> somnething about it since he wrote all that magic ;-)
>
Let me take a look at it.

> But yeah, feel free to add my SoB.
