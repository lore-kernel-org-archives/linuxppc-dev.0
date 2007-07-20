Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 21976DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 03:26:55 +1000 (EST)
Message-ID: <46A0EE6B.3000904@ovro.caltech.edu>
Date: Fri, 20 Jul 2007 10:18:35 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Problem faced while using workqueue in the character driver.
References: <11705912.post@talk.nabble.com>
In-Reply-To: <11705912.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Misbah,

> I am working on a character driver for FPGA, in which i am using a blocked
> read call on workqueue. The read call will be unblocked by the Interrupt
> from the Fpga to PPC Cpu.
> 
> The problem is that if the process is in blocked mode and then an Interrupt
> occurs the system gives kernel Panic where as it get unblocked and start
> reading the data but very soon it gets crashed.
> 
> Please send me your suggessins regarding the mentioned problem.

Er, without seeing the code, its a bit difficult to suggest
anything.

Perhaps you are using work-queues incorrectly?

Take a look at:

simple_work_queue.c

In the tar-ball

http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz

Which is described in:

http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf

There's also a more complex 'COBRA driver' here:

http://www.ovro.caltech.edu/~dwh/correlator/cobra_docs.html

Having an example of a working driver that uses work-queues
might help you.

Dave
