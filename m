Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 531BBDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 16:02:45 +1000 (EST)
Message-Id: <D44986B7-16A0-4AC2-B73F-3B4B05CF6ED2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18457.22551.705318.772517@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Thu, 1 May 2008 01:02:38 -0500
References: <Pine.LNX.4.64.0805010003510.8224@blarg.am.freescale.net>
	<18457.22551.705318.772517@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 12:41 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> Please pull from 'powerpc-next' branch of
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
>> powerpc-next
>>
>> to receive the following updates:
>
> I assume you want me to send these on to Linus before the merge window
> closes.  But this one:

yes.

>> Kumar Gala (1):
>>      [POWERPC] Set lower flag bits in regs->trap to indicate debug  
>> level exception
>
> needs a bit more motivation, since it is very new, and the commit
> message doesn't say why we want to do what the commit does.  What good
> thing will happen, or what bad thing will be averted, by having this
> commit in 2.6.26?

There's no harm either way with this one.  It can wait for post  
2.6.26, but its pretty trivial.

- k
