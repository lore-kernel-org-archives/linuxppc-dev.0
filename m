Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id A3FC367B8F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 22:24:46 +1100 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
References: <200611201200.36780.ml@stefan-roese.de>
Date: Mon, 20 Nov 2006 12:24:36 +0100
In-Reply-To: <200611201200.36780.ml@stefan-roese.de> (Stefan Roese's message
	of "Mon, 20 Nov 2006 12:00:36 +0100")
Message-ID: <87odr2mkcr.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Stefan" == Stefan Roese <ml@stefan-roese.de> writes:

Hi,

Stefan> This patch fixes a problem seen on multiple 4xx platforms,
Stefan> where the UART0 interrupt number is 0. The macro
Stefan> "is_real_interrupt" lead on those systems to not use an real
Stefan> interrupt but the timer based implementation.

That's not the proper way to fix this. Instead remap the interrupt
number to make 0 invalid.

I sent a similar patch some months ago and that was the reply I got:

http://marc.theaimsgroup.com/?t=114363521500003&r=1&w=2

-- 
Bye, Peter Korsgaard
