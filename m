Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 41C92DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 18:36:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: Ingo Molnar's message of  Saturday,
	28 February 2009 08:31:54 +0100 <20090228073154.GG9351@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<20090228073154.GG9351@elte.hu>
Message-Id: <20090228073604.84F3EFC3DA@magilla.sf.frob.com>
Date: Fri, 27 Feb 2009 23:36:04 -0800 (PST)
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> btw., shouldnt is_compat_task() expand to 0 in the 
> !CONFIG_COMPAT case? That way we could remove this #ifdef too. 
> (and move the first #ifdef inside the array initialization so 
> that we always have a mode1_syscalls_32[] array.)

I guess you mean define it in linux/compat.h then?
Go right ahead.  Whatever you want is fine by me.


Thanks,
Roland
