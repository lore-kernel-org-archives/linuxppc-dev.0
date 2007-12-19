Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5341DDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 04:36:19 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Per-Erik Johansson <perka@dtek.chalmers.se>
In-Reply-To: <5797.213.15.68.47.1198072613.squirrel@webmail.chalmers.se>
Subject: Re: Linux on Freescale e200
References: <5797.213.15.68.47.1198072613.squirrel@webmail.chalmers.se>
Message-Id: <67A10FA1-8F9D-4A87-BB67-C04EC9FA5BEF@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Date: Wed, 19 Dec 2007 11:36:10 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 19, 2007, at 7:56 AM, Per-Erik Johansson wrote:

> Hi
>
> I'm wondering if someone has ever tried to get Linux running on a
> Freescale e200 core?
> I found a patch to the Linux kernel from back in 2005:
> (http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-06/5731.html)
> And it is listed as a processor type in Linux-2.6.23.11
> I know that there has been some confusion about e200 and e500 cores,  
> old
> e200 renamed to e500, but from what I understand the e200 core now  
> listed
> in the kernel is the one currently being used in MPC55xx
>
> I'm having a MPC5554, e200z6 core, that I'm supposed to get Linux  
> running
> on (master thesis) and any pointers and tips are appreciated.
> Just finished porting/tweaking the Redboot boot loader, and I'm now  
> moving
> on to the Linux (porting?) part.

I'd suggest looking at getting u-boot running instead since that's we  
use on the majority of freescale PPCs.

We did a port a while back to the e200.. so most of the basic bits  
should be there.  There might be some bit rot from its like of usage.

What peripheral set are you looking to get working on the 5554?

- k
