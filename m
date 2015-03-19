Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D553F1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:54:34 +1100 (AEDT)
Message-ID: <1426809274.2581.0.camel@ellerman.id.au>
Subject: Re: [23/32] powerpc: copy_thread(): rename 'arg' argument to
 'kthread_arg'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alex Dowad <alexinbeijing@gmail.com>
Date: Fri, 20 Mar 2015 10:54:34 +1100
In-Reply-To: <550A794C.7020904@gmail.com>
References: <20150319064519.6BEA814010F@ozlabs.org>
 <550A794C.7020904@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Vineeth Vijayan <vvijayan@mvista.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-19 at 09:22 +0200, Alex Dowad wrote:
> On 19/03/15 08:45, Michael Ellerman wrote:
> > On Fri, 2015-13-03 at 18:14:46 UTC, Alex Dowad wrote:
> >> The 'arg' argument to copy_thread() is only ever used when forking a new
> >> kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
> >> with do_fork() and other arch-specific implementations of copy_thread()).
> >   
> > I don't understand the bit about consistency with do_fork() ?

> This series of patches includes one patch which renames the arg for 
> do_fork(), and others which rename the same arg for each arch-specific 
> implementation of copy_thread(). So if all of them are accepted and 
> merged, then all will be consistent. If only some of the patches are 
> accepted, I will rewrite the commit message so it doesn't mention 
> "consistency".

Ah OK, I only got patch 23, so I missed the context of the whole series.

I'll apply this one to the powerpc tree.

cheers
