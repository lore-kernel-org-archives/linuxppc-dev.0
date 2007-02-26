Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 41DFEDDED7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 03:21:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: using gdb/kgdb
Date: Mon, 26 Feb 2007 16:20:13 -0000
Message-ID: <35786B99AB3FDC45A8215724617919730105A3E4@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A175@MERCURY.inside.istor.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Charles Krinke" <ckrinke@istor.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> ... I think I have already accommodate
> this by using the latest gdb and cross-compiling it and it starts up
in
> architecture powerpc:common.
> ...

Charles

Last May I was trying to get gdb/kgdb working over a link from an i686
host to an MPC8541 target. At the time I had exactly your problem, and
the solution that worked for me was what I told you. It looks as if gdb
has moved on since then, but if you wish I can send you (off list) the
build of gdb that worked for me, and for which I needed to set
architecture to powerpc:common.

Another thing I did fairly early on was to abandon a serial connection
in favour of ethernet, and using:

(gdb) target remote udp:<ipaddress>:6443

but that probably makes no difference to the problem.

Clive
