Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id DE32267A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 02:32:46 +1100 (EST)
Date: Fri, 11 Feb 2005 08:32:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: emre kara <emrekara2002@yahoo.co.uk>
Message-ID: <20050211083244.A27632@cox.net>
References: <20050211135501.19902.qmail@web25710.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050211135501.19902.qmail@web25710.mail.ukl.yahoo.com>;
	from emrekara2002@yahoo.co.uk on Fri, Feb 11, 2005 at 01:55:01PM
	+0000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 1000MB (GMII) ports on IBM 440GX (ocotea)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 11, 2005 at 01:55:01PM +0000, emre kara wrote:
> Dear All;
> I have problems on ppc440gx ( IBM 440gx evaluatation
> board)  gigabit ethernet ports.
> I have configurated and compiled linux kernel version
> 2.4.29 (latest) for ocotea board and it worked fine
> with two MII /Fast Ethernet ports,but i can't find any
> way to configure GMII (gigabit) ethernet driver for
> other on chip two gigabit ports, in the platform
> specific file (arch/ppc/platforms/ocotea.c) the source
> configures only two fast ethernet ports.
> I have also loaded Montavista's preview kernel on my
> board and in this kernel,  four ethernet ports worked
> fine, but there are huge differences between two
> kernels so I can't find a way to overcome this
> problem.
> Is anyone have an idea for the solution?
> Thank you.
> Emre

You need to read the archives. This is a faq. Hint: you
want 2.6.

> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

The archives can be found here where you signed up for the list.

-Matt
