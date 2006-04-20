Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id D4B9767A3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 07:34:26 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Date: Thu, 20 Apr 2006 23:37:17 +0200
References: <200604202303.21680.antonio.dibacco@aruba.it>
	<20060420221801.55331e15@White64>
	<20060420211120.GA3546@mail.gnudd.com>
In-Reply-To: <20060420211120.GA3546@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604202337.17288.antonio.dibacco@aruba.it>
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

Flashing by myself means that I cannot use the mtd drivers? Then I cannot 
erase the flash as usual but I should reproduce in the application the 
algorithm to erase it, isn't it?

Bye,
Antonio.
P.S: I cannot believe that the author of the best book I've ever read, 
answered my question.

On Thursday 20 April 2006 23:11, Alessandro Rubini wrote:
> > but there is a chance that something bad could happen.
>
> If you mlockall(2) and sched_setscheduler(SCHED_FIFO) you can be
> somewhat confident that nothing bad can happen. However, you should flash
> by yourself (in the application, without resorting to the kernel.
>
> But please remember that Denk is right most of the time.
>
> /alessandro
