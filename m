Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id B6D802BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 03:30:24 +1000 (EST)
Date: Thu, 7 Oct 2004 10:30:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041007173023.GK14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
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

On Thu, Oct 07, 2004 at 12:00:35PM -0400, Robert P. J. Day wrote:
> On Thu, 7 Oct 2004, Tom Rini wrote:
> >On Thu, Sep 30, 2004 at 06:07:45AM +0200, Andreas Oberritter wrote:
> >
> >>Hi Dan,
> >>
> >>this patch for linuxppc-2.5 removes the old uart driver which doesn't
> >>work since a long time and has already been replaced by
> >>drivers/serial/cpm_uart/*.
> >
> >Can you please re-do this patch vs a linux-2.6 tree?  Thanks.
> 
> at the risk of jumping on on this, this patch would be affected by the 
> changes i made to Kconfig, and i've already listed (to myself) the 
> changes that are represented by this fix.  (see previous post, in 
> which i asked a few more annoying questions. :-)

Since these changes can go right into a linux-2.6 tree and out to Linus,
I should be able to get BitKeeper to happily merge these changes and
your changes.

-- 
Tom Rini
http://gate.crashing.org/~trini/
