Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 34BBC67A46
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 11:46:18 +1100 (EST)
Message-ID: <4238D351.9070001@jp.fujitsu.com>
Date: Thu, 17 Mar 2005 09:46:09 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050303124435.GA24233@Redstar.dorchain.net>	
	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	
	<20050304075703.GA15637@Redstar.dorchain.net>	
	<422FD24F.4070108@jp.fujitsu.com>	
	<20050310072803.GR4017@Redstar.dorchain.net>	<423073A9.70404@ybb.ne.jp>	
	<4231387D.6030204@jp.fujitsu.com>	<1110932285.25201.66.camel@gaston>	
	<4237C319.4050109@jp.fujitsu.com>
	<4237C8F0.1010605@jp.fujitsu.com>	
	<1110954539.5272.0.camel@gaston> <42383D85.7050108@ybb.ne.jp>
	<1111012124.15509.18.camel@gaston>
In-Reply-To: <1111012124.15509.18.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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

Benjamin Herrenschmidt wrote:

> 
> There may be other kernel bits calling syscall, it sounds saner to
> always make sure we don't reschedule when in atomic (though it's dubious
> that it's allowed to do syscalls in atomic regions, let's be safe
> there).
> 
> In fact, we are thinking about consolidating the syscall return path and
> the normal irq return path like we did on ppc64.
> 
Thkans, I make sense.
Would you send me Paul's patch?

Regards,

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
