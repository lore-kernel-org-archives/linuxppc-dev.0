Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsD2RVlzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:56 +1000 (AEST)
In-Reply-To: <596f97422c48baa55b3e197ada4d9faa17a5b66b.1493128546.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [REBASED,v4,1/2] powerpc: split ftrace bits into a separate file
Message-Id: <3wDCsD14bkz9sNX@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-25 at 13:55:53 UTC, "Naveen N. Rao" wrote:
> entry_*.S now includes a lot more than just kernel entry/exit code. As a
> first step at cleaning this up, let's split out the ftrace bits into
> separate files. Also move all related tracing code into a new trace/
> subdirectory.
> 
> No functional changes.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4781f015d35ce2e83632b6a938093b

cheers
