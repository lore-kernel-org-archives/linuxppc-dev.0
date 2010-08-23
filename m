Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id 2E80AB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 23:52:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [powerpc] Wire up fanotify_init, fanotify_mark,
	prlimit64 syscalls
Date: Mon, 23 Aug 2010 15:52:06 +0200
References: <m28w42prae.fsf@igel.home> <201008191937.20405.arnd@arndb.de>
	<m2tymqp7op.fsf@igel.home>
In-Reply-To: <m2tymqp7op.fsf@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008231552.07013.arnd@arndb.de>
Cc: Linuxppc-dev@ozlabs.org, Arnd Bergmann <arndbergmann@googlemail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 20 August 2010, Andreas Schwab wrote:
> See arch/powerpc/platforms/cell/spu_callbacks.c.
> 
>  * 4. They are optional and we can't rely on them being
>  *    linked into the kernel. Unfortunately, the cond_syscall
>  *    helper does not work here as it does not add the necessary
>  *    opd symbols:

Right. I should blame the person that wrote this comment.
If only I could remember who that was.

	Arnd
