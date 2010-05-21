Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 79B61B7D40
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 20:37:13 +1000 (EST)
Received: by wyb40 with SMTP id 40so552715wyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 03:37:10 -0700 (PDT)
Date: Fri, 21 May 2010 14:37:06 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Message-ID: <20100521103706.GA14962@oksana.dev.rtsoft.ru>
References: <1274433088.1931.63.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1274433088.1931.63.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 21, 2010 at 07:11:28PM +1000, Benjamin Herrenschmidt wrote:
[...]
> Anton Vorontsov (3):
>       powerpc/85xx: Add eTSEC 2.0 support for P1020RDB boards
>       powerpc/85xx: Fix P1020RDB boot hang due USB2
>       powerpc/83xx: Add MCU LEDs support for MPC837xRDB and MPC8315RDB boards
[...]
> Milton Miller (1):
>       powerpc: Use common cpu_die (fixes SMP+SUSPEND build)

Kumar,

As the cpu_die fix is now in, do you mind adding booke
hibernation patch again?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
