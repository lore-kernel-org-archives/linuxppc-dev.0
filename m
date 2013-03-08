Return-Path: <phdm@macqel.be>
Received: from smtp2.macqel.be (smtp2.macqel.be [194.78.208.39])
 by ozlabs.org (Postfix) with ESMTP id 5CE092C03BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 21:24:30 +1100 (EST)
Date: Fri, 8 Mar 2013 11:24:22 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: 3.9-rc1 powerpc ptrace.c: 'brk.len' is used uninitialized
Message-ID: <20130308102422.GA25184@frolo.macqel>
References: <20130306060058.GA3106@frolo.macqel>
 <21084.1362607788@ale.ozlabs.ibm.com> <20130306223645.GA15484@frolo.macqel>
 <31862.1362611670@ale.ozlabs.ibm.com> <20130307095907.GA16489@frolo.macqel>
 <22285.1362695571@ale.ozlabs.ibm.com> <11606.1362697414@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11606.1362697414@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:03:34AM +1100, Michael Neuling wrote:
> Michael Neuling <mikey@neuling.org> wrote:
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 245c1b6..8564515 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1428,6 +1428,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
>  
>  	brk.address = bp_info->addr & ~7UL;
>  	brk.type = HW_BRK_TYPE_TRANSLATE;
> +	brk.len = 0;
>  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
>  		brk.type |= HW_BRK_TYPE_READ;
>  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)

That's ok.  Thanks

Philippe
