Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm3Fk3bsDzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 15:39:06 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id ib6so4065909pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 22:39:06 -0700 (PDT)
Date: Fri, 8 Jul 2016 13:39:01 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
Message-ID: <20160708053901.GA6489@simonLocalRHEL7.x64>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467897678.27157.45.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2016 at 11:21:18PM +1000, Benjamin Herrenschmidt wrote:
> I think the right fix is that if a restore_sigcontext() has the MSR bits set,
> it should set the corresponding used_* flag.
> 
> Or is there a reason why that won't work ?

That sounds reaonable to me.
I will prepare a patch based on that.

Michael, Ben, Laurent,
Thanks the discussion and proposal.

- Simon
