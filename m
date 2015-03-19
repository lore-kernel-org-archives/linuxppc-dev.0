Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC2E81A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 17:45:19 +1100 (AEDT)
In-Reply-To: <1426270496-26362-13-git-send-email-alexinbeijing@gmail.com>
To: Alex Dowad <alexinbeijing@gmail.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [23/32] powerpc: copy_thread(): rename 'arg' argument to
 'kthread_arg'
Message-Id: <20150319064519.6BEA814010F@ozlabs.org>
Date: Thu, 19 Mar 2015 17:45:19 +1100 (AEDT)
Cc: Michael Neuling <mikey@neuling.org>,
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

On Fri, 2015-13-03 at 18:14:46 UTC, Alex Dowad wrote:
> The 'arg' argument to copy_thread() is only ever used when forking a new
> kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
> with do_fork() and other arch-specific implementations of copy_thread()).
 
I don't understand the bit about consistency with do_fork() ?

Otherwise it looks fine.

cheers
