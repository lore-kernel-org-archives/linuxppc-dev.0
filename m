Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 9C330DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 09:57:22 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-32.bayarea.dialup.o1.com [66.81.71.32])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m9PMtsrh081794
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 15:57:14 -0700 (PDT)
Message-ID: <4903A37A.50607@hypersurf.com>
Date: Sat, 25 Oct 2008 15:53:46 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>
In-Reply-To: <1224970389.7654.473.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-10-24 at 16:18 -0700, David Miller wrote:
> 
>>From: Kumar Gala <galak@kernel.crashing.org>
>>Date: Fri, 24 Oct 2008 10:57:38 -0500
>>
>>
>>>Commit 18404756765c713a0be4eb1082920c04822ce588 introduced a regression
>>>on a subset of SMP based PPC systems whose interrupt controller only
>>>allow setting an irq to a single processor.  The previous behavior
>>>was only CPU0 was initially setup to get interrupts.  Revert back
>>>to that behavior.
>>>
>>>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>
>>I really don't remember getting all of my interrupts only on cpu 0
>>on sparc64 before any of these changes.  I therefore find all of
>>this quite mysterious. :-)
> 
> 
> Well, I don't know how you do it but on powerpc, we explicitely fill the
> affinity masks at boot time when we can spread interrupts... Maybe we
> should change it the other way around and limit the mask when we can't ?
> It's hard to tell for sure at this stage.
> 
> Ben.
> 
What does this all mean to my GigE (dual 1.1 GHz 7455s)? Is this
thing supposed to be able to spread irq between its cpus?

kevin
