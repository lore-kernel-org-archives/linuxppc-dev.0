Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id B190FDDF63
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:46:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:46:51 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04690276@ismail.innsys.innovsys.com>
In-Reply-To: <4831F364.8020702@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
	<4831ECF0.5090101@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
	<4831F364.8020702@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Try calling irq_set_chip_and_handler() with handle_level_irq, rather
> than irq_set_chip().  The -rt patch doesn't seem to have threadified
>   the __do_IRQ() path.

The demuxer is setting itself up with set_irq_chained handler(), any
pointers on how to change to irq_set_chip_and_handler()?
