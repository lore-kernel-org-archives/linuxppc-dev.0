Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA9F667A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 14:42:48 +1100 (EST)
In-Reply-To: <20050210170658.GA20153@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0982a06b7c889ef71cf1a2a50dfd0fbe@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 10 Feb 2005 22:42:22 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Smith, Craig" <craig.d.smith@siemens.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 10, 2005, at 12:06 PM, Marcelo Tosatti wrote:

> How do you do track down the current TLB state? With a BDI?

Yes.  The BDI2000 is invaluable for this kind of debugging.

> Shouldnt it be loading the TLB entry which "seem to be OK" accordingly 
> to your
> analysis ??

Yes.

> BTW, we are seeing very bad slowdown on v2.4 compared to v2.6 on m8xx.

What are you using for performance measurements?  Standard
benchmarks I could run, too?

> Its likely to be cache related - I'm preparing a detailed email about 
> it.

OK.  Thanks.


	-- Dan
