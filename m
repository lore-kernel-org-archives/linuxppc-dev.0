Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 5D687DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 21:08:48 +1100 (EST)
Date: Fri, 22 Feb 2008 10:50:22 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: MPC8540 : What's "SPE used in kernel" ?
Message-ID: <20080222095022.GA635@ingate.macqel>
References: <20080221123534.GA17716@ingate.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080221123534.GA17716@ingate.macqel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear list,

I have just compiled linux-2.6.24 for a MPC8540 target using a MPC8540
specific gcc.

I then got tan infinity of "SPE used in kernel" messages.  Looking at the
sources I ifdeffed out the printk call in KernelSPE, and I now have a
silent kernel, that seems to work fine.

Is there something wrong in my setting and should I look further to
debug this problem or is this perfectly normal ?

I wonder why a kernel configured for E500 and compiled by a E500-specific gcc
triggers this message.  Is it invalid to use SPE instructions in the kernel 
or do I misunderstand the message ?

Philippe
