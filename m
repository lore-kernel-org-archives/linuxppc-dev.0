Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 7BC3267A76
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 16:50:06 +1100 (EST)
Message-ID: <4237C8F0.1010605@jp.fujitsu.com>
Date: Wed, 16 Mar 2005 14:49:36 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
References: <20050303124435.GA24233@Redstar.dorchain.net>		<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>		<20050304075703.GA15637@Redstar.dorchain.net>		<422FD24F.4070108@jp.fujitsu.com>		<20050310072803.GR4017@Redstar.dorchain.net>	<423073A9.70404@ybb.ne.jp>	
	<4231387D.6030204@jp.fujitsu.com>	<1110932285.25201.66.camel@gaston>
	<4237C319.4050109@jp.fujitsu.com>
In-Reply-To: <4237C319.4050109@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benjamin:

I forgot writing that I've sent the revised edition of
the patch to the PPC-Dev ML.
Please see the patch as ``boot time scheduling w hile atomic fix''
which I posted in 2005-03-15 from Patch tracking
system for PowerPC Linux as follows.

http://ozlabs.org/ppc32-patches/

It changes the implementation of kernel_thread function
to be performed with function call.

Regards,

Takeharu KATO wrote:

> But, the kernel invoke a system call trap when it execute kernel_thread call
> (at rest_init line:382) on PowerPC.
> The preemption count has positive value here.
> So, PowerPC linux kernel invoke system call when the preempt count is up.
> 

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
