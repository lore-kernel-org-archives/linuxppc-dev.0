Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 09F4C67B5F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 06:32:22 +1100 (EST)
Message-ID: <457326A2.2020402@ru.mvista.com>
Date: Sun, 03 Dec 2006 22:33:54 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: mingo@elte.hu
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>
In-Reply-To: <200611132252.58818.sshtylyov@ru.mvista.com>
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

Hello, I wrote:

> In addition to the clock jump-back check being falsely triggered by clock wrap
> with 32-bit cycles_t, as noticed by Kevin Hilman, there's another issue: using
> %Lx format to print 32-bit values warrants erroneous values on 32-bit machines
> like ARM and PPC32...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    What was the destiny of that patch? I haven't seen it accepted, haven't 
seen any comments... while this is not a mere warning fix. What am I expected 
to do to get it accepted -- recast it against 2.6.19-rt1?

>  kernel/latency_trace.c |   42 +++++++++++++++++++++---------------------
>  1 files changed, 21 insertions(+), 21 deletions(-)

WBR, Sergei
