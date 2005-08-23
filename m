Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 458F867FB3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 12:25:49 +1000 (EST)
Date: Mon, 22 Aug 2005 23:20:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050823022011.GE9667@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Enabling 8xx debug mode
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dan,

I know now that the BDI automatically enables debug mode by asserting
the DSCK signal (available through the JTAG port). Is there any way 
to enable debugging mode purely via software?

44.3.1.2 Entering Debug Mode

By appropriately programming the development port during reset, debug
mode can be entered immediately out of reset, thus allowing the user to
debug a ROM-less system. If DSCK is asserted throughout SRESET assertion
and then past SRESET negation, the processor takes a breakpoint
exception and goes directly to debug mode instead of fetching the reset
vector. To avoid entering debug mode after reset, DSCK must be negated
no later than seven clock cycles after SRESET negates, allowing the
processor to jump to the reset vector and begin normal execution. If
debug mode is entered immediately after reset, as shown in Figure 44-7,
ICR[DPI] is set. The user can enable events that can initiate debug mode
and determine which events require regular interrupt handling.
