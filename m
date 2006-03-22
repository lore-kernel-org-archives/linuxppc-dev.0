Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0A4867A33
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 05:39:43 +1100 (EST)
Date: Wed, 22 Mar 2006 14:16:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
Message-ID: <20060322131646.GB11714@elte.hu>
References: <20060322104143.GC30422@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060322104143.GC30422@krispykreme>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> One way to solve this is to always take runqueues in cpu id order. To 
> do this we add a cpu variable to the runqueue and check it in the 
> double runqueue locking functions.
> 
> Thoughts?

it's fine with me - the overhead to double_rq_lock() is minimal, and 
it's not critical code either.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
