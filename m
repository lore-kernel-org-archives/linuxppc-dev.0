Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0957D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 10:27:46 +1000 (EST)
Date: Mon, 18 Apr 2005 17:27:43 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050419002743.GA26825@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<20050416005026.GB1086@gate.ebshome.net>
	<c3d0340b05041814144133a608@mail.gmail.com>
	<20050418220605.GE25352@gate.ebshome.net>
	<c3d0340b050418161112b879b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050418161112b879b5@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 04:11:02PM -0700, Shawn Jin wrote:

[snip]

> However there could be a possible problem when a 2nd critical
> interrupt is asserted before the 1st one is served. Then fetching the
> VR returns the address for the 2nd interrupt. Of course if UIC can
> queue interrupts when calculating VRs, there wouldn't be such a
> problem.

According to the user manual, UIC indeed queues IRQs based on their 
priorities, so I guess there shouldn't be any problems.

Look at paragraphs titled "Vector generation scenarios".

-- 
Eugene
