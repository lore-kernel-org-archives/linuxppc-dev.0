Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD7D5DE02A
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 19:27:51 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1KXu3Q-0000x2-Uk
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 10:37:33 +0200
Date: Tue, 26 Aug 2008 10:32:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: [PATCH 4/4] Add kernel doc for the completion, fix
	kernel-doc-nano-HOWTO.txt
Message-ID: <20080826083202.GA24733@elte.hu>
References: <48B29696.3070808@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48B29696.3070808@hypersurf.com>
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

applied to tip/sched/devel - thanks Kevin!

	Ingo
