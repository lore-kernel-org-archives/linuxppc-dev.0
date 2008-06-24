Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A291CDDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 04:05:23 +1000 (EST)
Date: Tue, 24 Jun 2008 13:04:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: jumpingProgrammer <rabbitzp@163.com>
Subject: Re: Using DMA interrupt on MPC8313
Message-ID: <20080624180449.GB7804@loki.buserror.net>
References: <973175.42029.qm@web83503.mail.sp1.yahoo.com>
	<094E5361-18FC-47D7-BB7C-8A8AF89DBEC1@kernel.crashing.org>
	<470944.9117.qm@web83514.mail.sp1.yahoo.com>
	<2FCBCE91-8B77-4E78-A7F9-D4128980814F@kernel.crashing.org>
	<101441.49932.qm@web83508.mail.sp1.yahoo.com>
	<4856A3CA.4010905@freescale.com>
	<788575.91210.qm@web83508.mail.sp1.yahoo.com>
	<4856B3B4.9020206@freescale.com>
	<329782.75894.qm@web83515.mail.sp1.yahoo.com>
	<18084260.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18084260.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 10:54:28PM -0700, jumpingProgrammer wrote:
> 
> I use this in 8313erdb.dts, but can not find DMA info in
> /proc/interrupts.why?

Is the driver enabled, and did it call request_irq?

-Scott
