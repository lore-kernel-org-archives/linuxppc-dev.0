Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DD976B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Aug 2010 08:19:05 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Arnd Bergmann <arndbergmann@googlemail.com>
Subject: Re: [PATCH] [powerpc] Wire up fanotify_init, fanotify_mark,
	prlimit64 syscalls
References: <m28w42prae.fsf@igel.home> <201008191937.20405.arnd@arndb.de>
Date: Fri, 20 Aug 2010 00:19:02 +0200
In-Reply-To: <201008191937.20405.arnd@arndb.de> (Arnd Bergmann's message of
	"Thu, 19 Aug 2010 19:37:20 +0200")
Message-ID: <m2tymqp7op.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann <arndbergmann@googlemail.com> writes:

> On Thursday 19 August 2010 17:15:37 Andreas Schwab wrote:
>> +SYSCALL(fanotify_init)
>> +COMPAT_SYS(fanotify_mark)
>
> why not _SPU?

See arch/powerpc/platforms/cell/spu_callbacks.c.

 * 4. They are optional and we can't rely on them being
 *    linked into the kernel. Unfortunately, the cond_syscall
 *    helper does not work here as it does not add the necessary
 *    opd symbols:

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
