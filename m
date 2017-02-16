Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58d6fTpzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:45 +1100 (AEDT)
In-Reply-To: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, paulus@samba.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/xmon: Fix data-breakpoint
Message-Id: <3vP58d4wR4z9s8x@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 09:25:59 UTC, Ravi Bangoria wrote:
> Xmon data-breakpoint feature is broken.
> 
> Whenever there is a watchpoint match occurs, hw_breakpoint_handler will
> be called by do_break via notifier chains mechanism. If watchpoint is
> registered by xmon, hw_breakpoint_handler won't find any associated
> perf_event and returns immediately with NOTIFY_STOP. Similarly, do_break
> also returns without notifying to xmon.
> 
> Solve this by returning NOTIFY_DONE when hw_breakpoint_handler does not
> find any perf_event associated with matched watchpoint.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c21a493a2b44650707d06741601894

cheers
