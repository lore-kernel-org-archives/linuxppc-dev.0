Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: 3.9-rc1 powerpc ptrace.c: 'brk.len' is used uninitialized
In-reply-to: <20130306060058.GA3106@frolo.macqel>
References: <20130306060058.GA3106@frolo.macqel>
Date: Thu, 07 Mar 2013 09:09:48 +1100
Message-ID: <21084.1362607788@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> bisect tells me that since your commit 9422de3e953d0e60eb95f5430a9dd803eec1c6d7 
> "powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers",
> compiling linux fails with :
> 
>   cc1: warnings being treated as errors
>   arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
>   arch/powerpc/kernel/ptrace.c:1450: warning: 'brk.len' is used uninitialized in this function
>   arch/powerpc/kernel/ptrace.c:1352: note: 'brk.len' was declared here
> 
> could you look at that ?

Sure. 

How are you compiling this?  Is there a ppc defconfig that hits it?

Mikey
