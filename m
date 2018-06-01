Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86V3YXMzF0Tj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:58 +1000 (AEST)
In-Reply-To: <20180522090820.3307-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/kprobes: Fix build error with kprobes disabled.
Message-Id: <40y86T6St7z9rxs@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-22 at 09:08:20 UTC, "Aneesh Kumar K.V" wrote:
> arch/powerpc/kernel/stacktrace.c: In function ‘save_stack_trace_tsk_reliable’:
> arch/powerpc/kernel/stacktrace.c:176:28: error: ‘kretprobe_trampoline’ undeclared (first use in this function); did you mean ‘is_ftrace_trampoline’?
>    if (ip == (unsigned long)kretprobe_trampoline)
>                             ^~~~~~~~~~~~~~~~~~~~
>                             is_ftrace_trampoline
> arch/powerpc/kernel/stacktrace.c:176:28: note: each undeclared identifier is reported only once for each function it appears in
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5e3f0d15ae5f95bdde8d092a0884d2

cheers
