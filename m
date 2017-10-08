Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjh07qRzDr37
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:36 +1100 (AEDT)
In-Reply-To: <9e98f74834af349564b71bc8443bdad55d6e37c6.1505934128.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [v2,
 1/6] powerpc/kprobes: Some cosmetic updates to try_to_emulate()
Message-Id: <3y8xjg6RR0z9t4V@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-22 at 09:10:43 UTC, "Naveen N. Rao" wrote:
> 1. This is only used in kprobes.c, so make it static.
> 2. Remove the un-necessary (ret == 0) comparison in the else clause.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/22085337f5b9d7a7adf5c6cc4e007c

cheers
