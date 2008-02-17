Return-Path: <SRS0+cb85485ae34f2f3dd4ef+1638+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D51E9DDE26
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 21:22:52 +1100 (EST)
Subject: Re: Could the DTS experts look at this?
From: David Woodhouse <dwmw2@infradead.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47B1EF39.5000703@freescale.com>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
	<20080212002030.GE18348@localhost.localdomain>
	<47B0EB23.9040101@pikatech.com>	
	<20080212185251.GB4042@loki.buserror.net>
	<fa686aa40802121103s650fc10by197e9d5b65f09ceb@mail.gmail.com>
	<47B1EF39.5000703@freescale.com>
Content-Type: text/plain
Date: Sun, 17 Feb 2008 10:22:41 +0000
Message-Id: <1203243761.31173.170.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-12 at 13:10 -0600, Scott Wood wrote:
> Hmm?  All I meant was that it'd be nice if there were an option in the 
> Linux mtd code to disable the "look for another chip and cause a machine 
> check if it isn't there" functionality.  It was an aside from the 
> dts-variant issue.

Yeah, maybe -- although the probe code is hairy enough already; I'm not
massively keen on adding to it. Or even looking at it hard, if the truth
be told.

Alternatively, perhaps we should catch the machine check and recover
(like we do for failing I/O accesses on ppc32).

-- 
dwmw2
