Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 929F92BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 00:22:03 +1000 (EST)
Date: Fri, 8 Oct 2004 07:22:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041008142200.GX14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
	<0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0410071817420.8278@dell.enoriver.com>
	<20041007224220.GV14773@smtp.west.cox.net>
	<CF1BBAC1-18D0-11D9-9049-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CF1BBAC1-18D0-11D9-9049-003065F9B7DC@embeddededge.com>
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

On Thu, Oct 07, 2004 at 10:21:49PM -0400, Dan Malek wrote:
> 
> On Oct 7, 2004, at 6:42 PM, Tom Rini wrote:
> 
> >Oh, that.  console=ttyCPM1 is the answer if both SMC1 and SMC2 are
> >UARTs.
> 
> Yeah, that's normally the way it's done.
> 
> >Anticipating Dan screaming about this,
> 
> What kind of a person do you think I am?  I don't scream about
> anything.  I just point out facts and if others choose to ignore it
> I'll just remind everyone later.

I'm sorry Dan, I misjudged things.

-- 
Tom Rini
http://gate.crashing.org/~trini/
