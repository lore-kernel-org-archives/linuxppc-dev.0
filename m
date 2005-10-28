Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 413C168615
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:39:40 +1000 (EST)
Date: Fri, 28 Oct 2005 13:30:59 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Jander <david.jander@protonic.nl>
Message-ID: <20051028153059.GC18915@logos.cnet>
References: <200510280857.44625.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510280857.44625.david.jander@protonic.nl>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2005 at 08:57:44AM +0200, David Jander wrote:
> 
> Hi all,
> 
> Many people have said it before: 2.6 has a performance penalty specially for 
> embdedded systems.
> But now that I have 2.6 running on our 100MHz MPC852T based board, I was 
> shocked to see the result:
> The most simple task doing nothing but a closed loop of integer math runs at 
> _half_ the speed compared to kernel 2.4.25!!!!!

David,

Do you have CONFIG_PIN_TLB enabled?

If you do, please patch this in:

http://www.kernel.org/git/?p=linux/kernel/git/marcelo/8xx-fixes;a=commitdiff;h=a41ba028534c45280170c05c23609ea84f34b38a

And select DEBUG_PIN_TLBIE.
