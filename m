Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBB01DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 06:08:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Howto read I2C on MPC5200 Lite
Date: Sun, 18 Mar 2007 12:06:44 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B4B@MERCURY.inside.istor.com>
References: <20070307122430.GA73298@server.idefix.lan><4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com><20070309113506.GB6726@server.idefix.lan><4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com><20070309234251.GA68997@server.idefix.lan><20070311005535.GA39488@server.idefix.lan><20070315095758.GE14658@moe.telargo.com>
	<20070317085749.GA75794@server.idefix.lan>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have an embedded system with a PPC8541 using remote debugging across =
the serial port. I am using Fedora Core 6 on my host along with gdb 6.3 =
cross compiled for the ppc target and Linux 2.6.17.11 on the PPC8541 =
target.
=20
I can stop the kernel boot with 'kgdbwait' on the command line, startup =
gdb or ddd/gdb and set a breakpoint on do_fork which triggers reliably.
=20
>From there, I can delete that breakpoint, set a breakpoint further along =
in do_fork or continue using ddd to a location further along, but I =
cannot execute 'step'.
=20
When I execute a cont from either the gdb window or the ddd window, I do =
see the message:
=20
"Can't send signals to this remote system. SIGILL not sent.
=20
This problem occurs with or without ddd running the inferior debugger, =
so I suspect it is a gdb/target issue and not necessarily a ddd issue.
=20
Mostly, I am trying to understand what is going on.
=20
Charles

=20
