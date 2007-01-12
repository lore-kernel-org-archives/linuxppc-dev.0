Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0EF00DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 23:36:38 +1100 (EST)
Message-ID: <45A780D3.3020602@ru.mvista.com>
Date: Fri, 12 Jan 2007 15:36:35 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimsys.nl>
Subject: Re: status "Ingo's Real-Time" patch
References: <45A75F1B.2090506@aimsys.nl>
In-Reply-To: <45A75F1B.2090506@aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Norbert van Bolhuis wrote:

> Does anybody already (successfully) use "Ingo's Real-Time" patch
> for PPC.
> It can be found here:
> http://people.redhat.com/mingo/realtime-preempt/

> We tried applying an older patch for the 2.6.19 kernel on a
> MPC870 board, but it failed to compile.

    I don't know about the status of 2.6.19 RT patch, but we're successfulyl 
using earlier patches with some add-on -- for example, timeofday syscalls 
calls are broken in the stock RT patch causing glibc to return imprecise / 
incorrect time... Look in the linuxppc-dev archives for the extra patches I 
posted that hadn't gotten into RT patch still...

> Thanks,
> N.
		
WBR, Sergei
