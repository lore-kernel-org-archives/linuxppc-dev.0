Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 369B41007D2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2010 21:15:54 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: prasad@linux.vnet.ibm.com
Subject: Re: ppc_set_hwdebug vs ptrace_set_debugreg
References: <m2lj4ezhhd.fsf@igel.home> <20101129072233.GA15560@in.ibm.com>
Date: Mon, 29 Nov 2010 11:15:51 +0100
In-Reply-To: <20101129072233.GA15560@in.ibm.com> (K. Prasad's message of "Mon,
	29 Nov 2010 12:52:33 +0530")
Message-ID: <m38w0c77vs.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> Although ppc_set_hwdebug() can set DABR through set_dabr() in
> arch/powerpc/kernel/process.c, it is good to have it converted to use
> register_user_hw_breakpoint().

What do you mean with "good to have"?  It doesn't work without it unless
I disable PERF_EVENTS (which is the only way to disable
HAVE_HW_BREAKPOINT).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
