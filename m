Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4720ADE0E5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:47:00 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1KHDLC-0008D4-37
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 09:46:54 +0200
Date: Fri, 11 Jul 2008 09:46:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH -next-20080709] fixup stop_machine use cpu mask vs ftrace
Message-ID: <20080711074602.GB27849@elte.hu>
References: <200807081756.47140.rusty@rustcorp.com.au>
	<for-27-patch0-1@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <for-27-patch0-1@bga.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, linux-next@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Milton Miller <miltonm@bga.com> wrote:

> Hi Rusty, Ingo.
> 
> Rusty's patch [PATCH 3/3] stop_machine: use cpu mask rather than magic 
> numbers didn't find kernel/trace/ftrace.c in -next, causing an 
> immediate almost NULL pointer dereference in ftrace_dynamic_init.

Rusty - what's going on here? Please do not change APIs like that, which 
cause code to crash. Either do a compatible API change, or change it 
over in a way that causes clear build failures, not crashes.

	Ingo
