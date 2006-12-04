Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 239FD67A03
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 23:27:42 +1100 (EST)
Message-ID: <4574149B.5070602@ru.mvista.com>
Date: Mon, 04 Dec 2006 15:29:15 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu>
In-Reply-To: <20061204095131.GE7872@elte.hu>
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

Ingo Molnar wrote:

>>   What was the destiny of that patch? I haven't seen it accepted, 
>>haven't seen any comments... while this is not a mere warning fix. 
>>What am I expected to do to get it accepted -- recast it against 
>>2.6.19-rt1?

> i'd suggest to redo it - but please keep it simple and clean. Those 
> dozens of casts to u64 are quite ugly.

    Alas, there's *nothing* I can do about it with 32-bit cycles_t. And if you 
look at the kernel, this is not the only case of such "ugliness", look at this 
commit for example:

http://www.kernel.org/git/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=685143ac1f7a579a3fac9c7f2ac8f82e95af6864

> Why is cycles_t 32-bits on some 
> of the arches to begin with?

    I guess this was done for speed reasons. That's not a qustion for me 
although...

> 	Ingo

WBR, Sergei
