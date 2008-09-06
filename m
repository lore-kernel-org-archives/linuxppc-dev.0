Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B411DDE98
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Sep 2008 03:00:57 +1000 (EST)
Date: Sat, 6 Sep 2008 19:00:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: [PATCH v2 4/5] Add kernel doc for the completion, fix
	kernel-doc-nano-HOWTO.txt
Message-ID: <20080906170039.GE4856@elte.hu>
References: <48B919CB.3090509@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48B919CB.3090509@hypersurf.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Kevin Diggs <kevdig@hypersurf.com> wrote:

> This patch adds kernel doc for the completion feature. It is in 
> kernel/sched.c and include/linux/completion.h.
>
> An error in the split-man.pl PERL snippet in kernel-doc-nano-HOWTO.txt 
> is also fixed.

FYI, your patch is already in tip/sched/devel, based on your first mail 
on Aug 26. If there's a change in v2 please send a delta against 
tip/master:

  http://people.redhat.com/mingo/tip.git/README

Thanks,

	Ingo
