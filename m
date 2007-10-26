Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82DDBDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 13:23:34 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 13:23:25 +1000
Message-Id: <1193369005.7018.46.camel@pasglop>
Mime-Version: 1.0
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org,
	Matt Mackall <mpm@selenic.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> This is actually 405.  Does that have the same issue?

hrm... I don't remember :-) There -is- something fishy about the icache
on 405 but I don't remember for sure. Try sticking an iccci in there and
tell us if that helps.

Ben.
