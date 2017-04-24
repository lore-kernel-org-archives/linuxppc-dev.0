Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLW2lpYzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:31 +1000 (AEST)
In-Reply-To: <c4d682fbba703e58853feb81e306e006f59ca62e.1492606062.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [v4,4/6] powerpc: kprobes: add support for KPROBES_ON_FTRACE
Message-Id: <3wBhLW1xZrz9s8c@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:52:26 UTC, "Naveen N. Rao" wrote:
> Allow kprobes to be placed on ftrace _mcount() call sites. This
> optimization avoids the use of a trap, by riding on ftrace
> infrastructure.
> 
> This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> MPROFILE_KERNEL, which is only currently enabled on powerpc64le with
> newer toolchains.
> 
> Based on the x86 code by Masami.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ead514d5fb30a0889d51c0f0e35c3e

cheers
