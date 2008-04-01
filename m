Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 62A10DE136
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 00:05:03 +1100 (EST)
Message-ID: <47F232D2.9040200@ru.mvista.com>
Date: Tue, 01 Apr 2008 17:04:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] powerpc: Describe memory-mapped RAM&ROM chips OF
	bindings
References: <200803311839.10519.laurentp@cse-semaphore.com>
	<200804011047.42971.laurentp@cse-semaphore.com>
	<Pine.LNX.4.64.0804010217470.3571@t2.domain.actdsltmp>
	<200804011439.04905.laurentp@cse-semaphore.com>
In-Reply-To: <200804011439.04905.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, MTD mailing list <linux-mtd@lists.infradead.org>,
	Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:

>>>On Monday 31 March 2008 19:06, Sergei Shtylyov wrote:

>>>>>       p) Freescale Synchronous Serial Interface
>>>>>-	  q) USB EHCI controllers
>>>>>+      q) USB EHCI controllers
>>>>>+      r) Memory-mapped RAM & ROM

>>>>    Memory-mapped RA/RO Memory again? Should better drop this. :-)

>>>You're quite picky, aren't you ? :-)

>>>I suppose "Memory-mapped RA & RO" won't be accepted, so what about "Auxiliary
>>>RAM & ROM" ?

>>Direct-mapped?

> Fine with me. Sergei ?

    I agree. The only thing that somewhat worries me it that it will have no 
"compatible" prop...

WBR, Sergei
