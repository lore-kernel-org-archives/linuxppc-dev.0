Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC6CC1A0725
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 11:00:43 +1000 (AEST)
Message-ID: <1441069243.26730.3.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 1/9] powerpc: allocate sys_membarrier system call
 number
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-api
 <linux-api@vger.kernel.org>, linux-kernel@vger.kernel.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 01 Sep 2015 11:00:43 +1000
In-Reply-To: <131898944.32688.1441035174419.JavaMail.zimbra@efficios.com>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1440698215-8355-2-git-send-email-mathieu.desnoyers@efficios.com>
 <1441004045.5735.8.camel@ellerman.id.au>
 <131898944.32688.1441035174419.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-31 at 15:32 +0000, Mathieu Desnoyers wrote:
> ----- On Aug 31, 2015, at 2:54 AM, Michael Ellerman mpe@ellerman.id.au wrote:
> 
> > On Thu, 2015-08-27 at 13:56 -0400, Mathieu Desnoyers wrote:
> >> Allow it to be used from SPU, since it should not have unwanted
> >> side-effects.

> > $ ./membarrier_test
> > membarrier MEMBARRIER_CMD_QUERY syscall available.
> > membarrier: MEMBARRIER_CMD_SHARED success.
> > membarrier: tests done!
> > 
> > Which looks good.
> > 
> > Assuming the membarrier support hits 4.3, I'll take this via my tree for 4.3
> > also.
> 
> Great! I'll take care of your comments about self-tests,

Thanks. None of them are critical so we can always fix them later.

cheers
