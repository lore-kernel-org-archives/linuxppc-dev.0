Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp09.mail.mci.yahoo.co.jp (ybbsmtp09.mail.mci.yahoo.co.jp
	[210.80.241.183]) by ozlabs.org (Postfix) with SMTP id 5380067A67
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 01:07:03 +1100 (EST)
Message-ID: <42383D85.7050108@ybb.ne.jp>
Date: Wed, 16 Mar 2005 23:07:01 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050303124435.GA24233@Redstar.dorchain.net>	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	<20050304075703.GA15637@Redstar.dorchain.net>	<422FD24F.4070108@jp.fujitsu.com>	<20050310072803.GR4017@Redstar.dorchain.net>	<423073A9.70404@ybb.ne.jp>	<4231387D.6030204@jp.fujitsu.com>	<1110932285.25201.66.camel@gaston>	<4237C319.4050109@jp.fujitsu.com>
	<4237C8F0.1010605@jp.fujitsu.com> <1110954539.5272.0.camel@gaston>
In-Reply-To: <1110954539.5272.0.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I can not figure out why my previous patch is more preferable than
later one.
Could you explain the reason of that please.

Regards,

>>
>>http://ozlabs.org/ppc32-patches/
>>
>>It changes the implementation of kernel_thread function
>>to be performed with function call.
> 
> 
> I prefer your previous patch. Paul hacked it a bit and will commit his
> modified version.
> 
> Ben.
> 

-- 
Takeharu KATO
