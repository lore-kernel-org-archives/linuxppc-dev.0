Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F3972BF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Oct 2004 09:16:37 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
In-Reply-To: <41827E99.1090206@vision.caltech.edu>
References: <41816863.9020000@vision.caltech.edu>
	<1099006771.29690.83.camel@gaston> <4181878C.20605@vision.caltech.edu>
	<1099011090.29689.96.camel@gaston>
	<41827E99.1090206@vision.caltech.edu>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 09:11:09 +1000
Message-Id: <1099091469.29689.150.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-10-29 at 10:32 -0700, Arrigo Benedetti wrote:

> Have these interrupts anything to do with the load balancer? I have 
> disabled the load balancer code
> in linux/sched.c (just commented out all the code in load_balance()).
> Maybe the only solution is to write a kernel module?

Yes, a kernel module is probably your best solution here

Ben.
