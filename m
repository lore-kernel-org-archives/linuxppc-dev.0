Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 01A0F6890B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Dec 2005 07:41:01 +1100 (EST)
Date: Fri, 30 Dec 2005 14:40:01 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <20051230204001.GA7450@pb15.lixom.net>
References: <D5FE4784-0908-4A8E-9231-D1741F5592DF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D5FE4784-0908-4A8E-9231-D1741F5592DF@kernel.crashing.org>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: powerpc.git broken for ARCH=ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 30, 2005 at 12:17:56PM -0600, Kumar Gala wrote:
> Ben,
> 
> It looks like you broke ARCH=ppc builds:
> 
> arch/ppc/kernel/time.c: In function `wakeup_decrementer':
> arch/ppc/kernel/time.c:125: warning: implicit declaration of function  
> `last_jiffy_stamp'
> arch/ppc/kernel/time.c:125: error: invalid lvalue in assignment
> arch/ppc/kernel/time.c: In function `timer_interrupt':
> arch/ppc/kernel/time.c:189: error: invalid lvalue in assignment
> arch/ppc/kernel/time.c: In function `time_init':
> arch/ppc/kernel/time.c:331: error: invalid lvalue in assignment
> 
> In asm-powerpc/hardirq.h you removed the defn of last_jiffy_stamp.   
> Suggestions on what the right fix is for arch=ppc?

Hmm, it's pretty annoying that cleanups and chances of powerpc can break
ppc. How much of asm-powerpc is pulled into an ARCH=ppc build?


-Olof
