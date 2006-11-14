Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB9776806E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 13:09:54 +1100 (EST)
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe cycle]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061113175808.GA15565@aepfle.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de> <20061106165752.GA25595@aepfle.de>
	<1162851570.28571.361.camel@localhost.localdomain>
	<20061107070839.GA31460@aepfle.de>
	<1162883865.28571.439.camel@localhost.localdomain>
	<tkrat.bedb19657ae90fd7@s5r6.in-berlin.de>
	<20061113175808.GA15565@aepfle.de>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 13:09:44 +1100
Message-Id: <1163470184.5940.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Gioele Barabucci <dev@gioelebarabucci.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The pismo usually locks up after the fist rmmod. With a few delays
> around the feature calls, a few more modprobe/rmmod cycles are possible.
> But it still locks up after a while.

What if you just remove all the feature calls ?

Ben.
