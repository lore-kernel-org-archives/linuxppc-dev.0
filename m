Return-Path: <arndbergmann@googlemail.com>
From: Arnd Bergmann <arndbergmann@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [powerpc] Wire up fanotify_init, fanotify_mark,
	prlimit64 syscalls
Date: Thu, 19 Aug 2010 19:37:20 +0200
References: <m28w42prae.fsf@igel.home>
In-Reply-To: <m28w42prae.fsf@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008191937.20405.arnd@arndb.de>
Cc: Linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 August 2010 17:15:37 Andreas Schwab wrote:
> +SYSCALL(fanotify_init)
> +COMPAT_SYS(fanotify_mark)

why not _SPU? If it doesn't depend on getting signals,
SPUs should be able to use it.

	Arnd
