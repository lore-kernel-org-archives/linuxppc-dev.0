Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D990BDE44C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 01:15:06 +1000 (EST)
Message-Id: <EFAF51F5-D2A4-4A8F-AB94-0A746B67E190@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807241621.58719.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCHv2] cpm_uart: Fix break generation
Date: Thu, 24 Jul 2008 10:14:57 -0500
References: <200806261338.19358.laurentp@cse-semaphore.com>
	<200807241621.58719.laurentp@cse-semaphore.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 24, 2008, at 9:21 AM, Laurent Pinchart wrote:

> When generating a break condition on a serial port, the CPM must be  
> told
> beforehand how long the break should be. Unfortunately, this  
> information is
> not available through the current serial break handling API. This  
> patch works
> around the problem by requesting a 32767 characters break followed  
> by a 0
> characters break after the requested duration. The CPM will stop the  
> first
> break when the second one is requested. This might not work with  
> future CPM
> revisions.

What do you mean by future CPM revision?  Do you mean QE?

- k
