Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp15.mail.mci.yahoo.co.jp (ybbsmtp15.mail.mci.yahoo.co.jp
	[210.80.241.189]) by ozlabs.org (Postfix) with SMTP id 3BBD267A6B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Mar 2005 09:21:53 +1100 (EST)
Message-ID: <423219FF.2080400@ybb.ne.jp>
Date: Sat, 12 Mar 2005 07:21:51 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Joerg Dorchain <joerg@dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	<20050304075703.GA15637@Redstar.dorchain.net>	<422FD24F.4070108@jp.fujitsu.com>
	<20050310072803.GR4017@Redstar.dorchain.net>
In-Reply-To: <20050310072803.GR4017@Redstar.dorchain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling while atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

> 
> I came to the same idea. This explains as well why the i386 party does
> not notice the effect, as their first interrupt happen later (different
> HZ value)
> 

FYI, i386 party's kernel_thread function calls do_fork directly, 
however, do_fork is called via syscall trap(clone syscall) in powerpc.
So, this difference may be taken place.

IMHO, from this point of view, the real fix for this problem is change 
the way to implement kernel_thread function of PowerPC like as other 
architecture does.

Regards,


-- 
Takeharu KATO
