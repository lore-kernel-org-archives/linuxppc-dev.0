Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4119C67B5B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 08:59:49 +1100 (EST)
Date: Mon, 4 Dec 2006 22:58:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
Message-ID: <20061204215840.GA23604@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
	<200612042256.51823.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612042256.51823.zippel@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Roman Zippel <zippel@linux-m68k.org> wrote:

> While I'm not against this patch, but on m68k I prefer a 32bit cycle 
> type (however it's called), so it doesn't solve the original problem.

i havent changed the cycles_t type - it's still 32-bit. I agree with you 
that we dont want to bloat 32-bit arch-level code by artificially 
forcing everyone to a 64-bit cycles_t.

	Ingo
