Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C5F22BDF2
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Nov 2004 10:04:27 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
In-Reply-To: <41893BFB.1010903@vision.caltech.edu>
References: <41893BFB.1010903@vision.caltech.edu>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 09:56:21 +1100
Message-Id: <1099522581.31629.84.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: printk problems
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-11-03 at 12:13 -0800, Arrigo Benedetti wrote:
> For some reason I can't get printk() to work on a YDL 4.0 system. I have 
> followed all the instructions, like
> setting the correct log level in /proc/sys/kernel/printk, killing klogd 
> and then
> 
> cat /proc/kmsg
> 
> but I do not see any message from printk. The printk is in a new kernel 
> system call that I wrote.
> Any ideas?

Are you sure you are reaching your syscall at all ? Besides, why are you
adding a syscall in the first place ? (just curious ... it's usually the
wrong solution :)

Ben.
