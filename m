Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySP9F6CqpzDr6D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 23:12:33 +1100 (AEDT)
In-Reply-To: <6935a132af2cbfe21de0976ad29601b4dd54a4a6.1509374094.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [2/2] powerpc/kprobes: Dereference function pointers only if the
 address does not belong to kernel text
Message-Id: <3ySP9F58rdz9t34@ozlabs.org>
Date: Thu,  2 Nov 2017 23:12:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-30 at 15:12:09 UTC, "Naveen N. Rao" wrote:
> This makes the changes introduced in commit 83e840c770f2c5
> ("powerpc64/elfv1: Only dereference function descriptor for non-text
> symbols") to be specific to the kprobe subsystem.
> 
> We previously changed ppc_function_entry() to always check the provided
> address to confirm if it needed to be dereferenced. This is actually
> only an issue for kprobe blacklisted asm labels (through use of
> _ASM_NOKPROBE_SYMBOL) and can cause other issues with ftrace. Also, the
> additional checks are not really necessary for our other uses.
> 
> As such, move this check to the kprobes subsystem.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e6c4dcb308160115287afd87afb63b

cheers
