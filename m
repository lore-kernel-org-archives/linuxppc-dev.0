Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2064B67A78
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 17:29:08 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
In-Reply-To: <4237C8F0.1010605@jp.fujitsu.com>
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>
	<20050304075703.GA15637@Redstar.dorchain.net>
	<422FD24F.4070108@jp.fujitsu.com>
	<20050310072803.GR4017@Redstar.dorchain.net>	<423073A9.70404@ybb.ne.jp>
	<4231387D.6030204@jp.fujitsu.com>	<1110932285.25201.66.camel@gaston>
	<4237C319.4050109@jp.fujitsu.com>  <4237C8F0.1010605@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 17:28:59 +1100
Message-Id: <1110954539.5272.0.camel@gaston>
Mime-Version: 1.0
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

On Wed, 2005-03-16 at 14:49 +0900, Takeharu KATO wrote:
> Hi Benjamin:
> 
> I forgot writing that I've sent the revised edition of
> the patch to the PPC-Dev ML.
> Please see the patch as ``boot time scheduling w hile atomic fix''
> which I posted in 2005-03-15 from Patch tracking
> system for PowerPC Linux as follows.
> 
> http://ozlabs.org/ppc32-patches/
> 
> It changes the implementation of kernel_thread function
> to be performed with function call.

I prefer your previous patch. Paul hacked it a bit and will commit his
modified version.

Ben.
