Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81DBC67A2E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 20:52:05 +1100 (EST)
Date: Mon, 4 Dec 2006 10:51:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
Message-ID: <20061204095131.GE7872@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<457326A2.2020402@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <457326A2.2020402@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>    What was the destiny of that patch? I haven't seen it accepted, 
> haven't seen any comments... while this is not a mere warning fix. 
> What am I expected to do to get it accepted -- recast it against 
> 2.6.19-rt1?

i'd suggest to redo it - but please keep it simple and clean. Those 
dozens of casts to u64 are quite ugly. Why is cycles_t 32-bits on some 
of the arches to begin with?

	Ingo
