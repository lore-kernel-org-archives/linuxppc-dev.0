Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 9CC272BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 08:42:22 +1000 (EST)
Date: Thu, 7 Oct 2004 15:42:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041007224220.GV14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
	<0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0410071817420.8278@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410071817420.8278@dell.enoriver.com>
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

On Thu, Oct 07, 2004 at 06:27:51PM -0400, Robert P. J. Day wrote:

> at least, that's what it looks like.  but there's no equivalent 
> selection to pick *exactly* where you want your console in that 
> submenu.  i wasn't suggesting that all the above *features* had to be 
> expunged -- just that those specific variables were related to the old 
> UART way of doing things and had to be dealt with, one way or the 
> other.

Oh, that.  console=ttyCPM1 is the answer if both SMC1 and SMC2 are
UARTs.

Anticipating Dan screaming about this, I'll point to the SH boards where
the first UART is wired up to odd connectors, and they don't do the "Is
console on uart1 ?" thing.

-- 
Tom Rini
http://gate.crashing.org/~trini/
