Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EAF9DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 13:38:46 +1000 (EST)
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <seanm@seanm.ca>
In-Reply-To: <20080504204104.7eea7618@lappy.seanm.ca>
References: <20080504204104.7eea7618@lappy.seanm.ca>
Content-Type: text/plain
Date: Mon, 05 May 2008 13:38:39 +1000
Message-Id: <1209958719.21644.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-05-04 at 20:41 -0400, Sean MacLennan wrote:
> This is a bit OT, but I got the warning in the subject from
> checkpatch.pl for a piece of code. The code *is* using a mutex. Does it
> actually mean I shouldn't use a mutex?
> 
> The code declares a global mutex:
> 
> 	static DECLARE_MUTEX(list_lock);
> 
> The odds of two accesses to the list_lock at the same time are zero.
> But it would be Very Bad(tm) if it did happen. Since the odds of
> contention are near zero, the cost of the mutex is near zero, so I put
> it in.
> 
> I think I can safely ignore the warning, but I want to make sure....

Show us the code... It could be a bug in checkpatch or you using 
the wrong functions somewhere ...

Ben.
