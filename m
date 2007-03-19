Return-Path: <akpm@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 36779DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 10:43:03 +1100 (EST)
Date: Mon, 19 Mar 2007 16:42:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-Id: <20070319164243.026fdbfd.akpm@linux-foundation.org>
In-Reply-To: <1173394873.3461.510.camel@pmac.infradead.org>
References: <1173394873.3461.510.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sam@ravnborg.org, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 08 Mar 2007 23:01:13 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> Most system calls seem to get added to i386 first. This patch
> automatically generates a warning for any new system call which is
> implemented on i386 but not the architecture currently being compiled.
> On PowerPC at the moment, for example, it results in these warnings:
> init/missing_syscalls.h:935:3: warning: #warning syscall sync_file_range not implemented
> init/missing_syscalls.h:947:3: warning: #warning syscall getcpu not implemented
> init/missing_syscalls.h:950:3: warning: #warning syscall epoll_pwait not implemented

hm, did you try running this on x86_64?

In file included from init/missing_syscalls.c:73:
init/missing_syscalls.h:23:3: warning: #warning syscall waitpid not implemented
init/missing_syscalls.h:68:3: warning: #warning syscall umount not implemented
init/missing_syscalls.h:77:3: warning: #warning syscall stime not implemented
init/missing_syscalls.h:104:3: warning: #warning syscall nice not implemented
init/missing_syscalls.h:146:3: warning: #warning syscall signal not implemented
init/missing_syscalls.h:203:3: warning: #warning syscall sigaction not implemented
init/missing_syscalls.h:206:3: warning: #warning syscall sgetmask not implemented
init/missing_syscalls.h:209:3: warning: #warning syscall ssetmask not implemented
init/missing_syscalls.h:218:3: warning: #warning syscall sigsuspend not implemented
init/missing_syscalls.h:221:3: warning: #warning syscall sigpending not implemented
init/missing_syscalls.h:269:3: warning: #warning syscall readdir not implemented
init/missing_syscalls.h:308:3: warning: #warning syscall socketcall not implemented
init/missing_syscalls.h:353:3: warning: #warning syscall ipc not implemented
init/missing_syscalls.h:359:3: warning: #warning syscall sigreturn not implemented
init/missing_syscalls.h:380:3: warning: #warning syscall sigprocmask not implemented
init/missing_syscalls.h:404:3: warning: #warning syscall bdflush not implemented
init/missing_syscalls.h:422:3: warning: #warning syscall _llseek not implemented
init/missing_syscalls.h:428:3: warning: #warning syscall _newselect not implemented
init/missing_syscalls.h:800:3: warning: #warning syscall statfs64 not implemented
init/missing_syscalls.h:803:3: warning: #warning syscall fstatfs64 not implemented
init/missing_syscalls.h:947:3: warning: #warning syscall getcpu not implemented
init/missing_syscalls.h:950:3: warning: #warning syscall epoll_pwait not implemented
init/missing_syscalls.h:953:3: warning: #warning syscall lutimesat not implemented
init/missing_syscalls.h:956:3: warning: #warning syscall revokeat not implemented
init/missing_syscalls.h:959:3: warning: #warning syscall frevoke not implemented
