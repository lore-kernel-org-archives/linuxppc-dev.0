Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A1B7679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 05:10:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2UIAuRf003245
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 13:10:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2UIApo9239052
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 13:10:51 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2UIAof5026737
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 13:10:51 -0500
Date: Thu, 30 Mar 2006 12:10:49 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/5] powerpc: Move
	create_(instruction|branch|function_call) into util.h
Message-ID: <20060330181049.GN2172@austin.ibm.com>
References: <1143699173.339118.857634197021.qpush@concordia>
	<20060330061300.0B12567B6C@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060330061300.0B12567B6C@ozlabs.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,
A minor quibble from the dept. of naming things:

On Thu, Mar 30, 2006 at 05:12:59PM +1100, Michael Ellerman wrote:
> ===================================================================
> --- /dev/null
> +++ to-merge/include/asm-powerpc/util.h
> @@ -0,0 +1,56 @@
> +
> +#ifndef _ASM_POWERPC_UTIL_H
> +#define _ASM_POWERPC_UTIL_H
> +
> +static inline void create_instruction(unsigned long addr, unsigned int instr)


Surely there is a more descriptive name for this new file than "util.h"?

How about "dynamic_insn.h" or "insn_patch.h" or "dyn_fixup.h" or
something like that? 

--linas
