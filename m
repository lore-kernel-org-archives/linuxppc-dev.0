Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0815D67BD5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 05:03:12 +1100 (EST)
Message-ID: <45746338.7050903@ru.mvista.com>
Date: Mon, 04 Dec 2006 21:04:40 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit
	cycles_t	in	latency_trace.c (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>	<457326A2.2020402@ru.mvista.com>
	<20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com>
In-Reply-To: <4574149B.5070602@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Sergei Shtylyov wrote:

>>Why is cycles_t 32-bits on some 
>>of the arches to begin with?

>     I guess this was done for speed reasons.

    The whole 64-bit timebase can't be rad atomically on PPC32. ARM probably 
has stricter limitations...

>>	Ingo

WBR, Sergei
