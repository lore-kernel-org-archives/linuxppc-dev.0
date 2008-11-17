Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB81EDDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 01:33:39 +1100 (EST)
Message-Id: <A84F59D4-E594-4C31-B881-B35B93DBDB97@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Steven Rostedt <srostedt@redhat.com>
In-Reply-To: <491F107E.4070702@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH][for 2.6.28] Remove -mno-spe flags as they dont belong
Date: Mon, 17 Nov 2008 08:33:30 -0600
References: <1226772154-6109-1-git-send-email-galak@kernel.crashing.org>
	<491F107E.4070702@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 15, 2008, at 12:10 PM, Steven Rostedt wrote:

> Kumar Gala wrote:
>> For some unknown reason at Steven Rostedt added in disabling of the  
>> SPE
>> instruction generation for e500 based PPC cores in commit
>> 6ec562328fda585be2d7f472cfac99d3b44d362a.
>>
>
> The unknown reason was that my PPC64 failed to compile without  
> it ;-) It was unknown because I forgot to mention that in the change  
> log (my bad).

Are you sure you were building a ppc64 kernel?  This makes no sense in  
that the -mno-spe flag should not be relevant at all to such a kernel  
build.  (No ppc64 chip has SPE support and thus the compiler doesnt  
support generation of the instructions in that mode).

Were you building some ppc32 targeted kernel?

- k
