Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B5AD167A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 10:11:13 +1100 (EST)
Date: Sat, 12 Feb 2005 15:11:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: emre kara <emrekara2002@yahoo.co.uk>
Message-ID: <20050212231109.GA609@gate.ebshome.net>
References: <20050211135501.19902.qmail@web25710.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050211135501.19902.qmail@web25710.mail.ukl.yahoo.com>
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

There is an experimental PPC4xx NAPI EMAC driver, which has 440GX 
support (GigE, TAH, scatter-gather, jumbo) for 2.4.30-pre1 (2.6 
version will follow shortly).

Patch can be found at http://kernel.ebshome.net/.

Please, note, full 440GX support is newly added feature and therefore 
don't consider it stable yet. I'm in process of testing it. So, use 
it at your own risk.

--
Eugene
