Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A6DD1A088D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 15:13:27 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 31 Jul 2015 10:43:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0F899E0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 10:47:32 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6V5DKOl50200584
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 10:43:20 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6V5DJx7015530
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 10:43:19 +0530
Date: Fri, 31 Jul 2015 10:43:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: paulus@samba.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] powerpc/ftrace: add powerpc timebase as a trace clock
 source
Message-ID: <20150731051317.GC2683@naverao1-tp.in.ibm.com>
References: <1429865684-6214-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429865684-6214-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/04/24 02:24PM, Naveen N Rao wrote:
> Add a new powerpc-specific trace clock using the timebase register,
> similar to x86-tsc. This gives us
> - a fast, monotonic, hardware clock source for trace entries, and
> - a clock that can be used to correlate events across cpus as well as across
>   hypervisor and guests.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes since v1:
> - removed unnecessary #ifdef in trace_clock.h
> - changed config build dependency for trace_clock.o from TRACE_CLOCK to TRACING

Bump.
Michael, can you please pick this up?

- Naveen
