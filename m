Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 62BB52BDD7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 01:40:32 +1000 (EST)
Date: Thu, 7 Oct 2004 08:40:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Message-ID: <20041007154029.GE14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096517265.27208.18.camel@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 30, 2004 at 06:07:45AM +0200, Andreas Oberritter wrote:

> Hi Dan,
> 
> this patch for linuxppc-2.5 removes the old uart driver which doesn't
> work since a long time and has already been replaced by
> drivers/serial/cpm_uart/*.

Can you please re-do this patch vs a linux-2.6 tree?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
