Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A26431A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:26:59 +1000 (AEST)
In-Reply-To: <1429865684-6214-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: [v2] powerpc/ftrace: add powerpc timebase as a trace clock source
Message-Id: <20150810092659.9116614027C@ozlabs.org>
Date: Mon, 10 Aug 2015 19:26:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-24-04 at 08:54:44 UTC, "Naveen N. Rao" wrote:
> Add a new powerpc-specific trace clock using the timebase register,
> similar to x86-tsc. This gives us
> - a fast, monotonic, hardware clock source for trace entries, and
> - a clock that can be used to correlate events across cpus as well as across
>   hypervisor and guests.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/197165d44925bd0fa892

cheers
