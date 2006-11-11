Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9544367F10
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 12:31:42 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45551185.8080704@s5r6.in-berlin.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<tkrat.fa66c98c1012e645@s5r6.in-berlin.de>
	<1163200208.4982.193.camel@localhost.localdomain>
	<45551185.8080704@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 12:31:32 +1100
Message-Id: <1163208692.4982.199.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Gioele Barabucci <dev@gioelebarabucci.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 00:55 +0100, Stefan Richter wrote:
> Benjamin Herrenschmidt wrote:
> > On Sat, 2006-11-11 at 00:07 +0100, Stefan Richter wrote:
> >> Actually, shouldn't ohci1394_pci_remove enlcose the platform code into
> >>
> >> 	if (machine_is(powermac)) {
> 
> > Yes.
> 
> And how does this expression evaluate on PowerBook G3 "Pismo"?

This will be true on all powerpc based apple machines, so it will be
true there too.

Ben.
