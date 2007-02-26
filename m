Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11A73DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 02:34:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: using gdb/kgdb
Date: Mon, 26 Feb 2007 07:34:08 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A175@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>=20
At this point, try setting the architecture as below (you can
show the current architecture first, to check that it is
wrongly set to "e500", which doesn't work properly)

(gdb) show architecture
The target architecture is set automatically (currently powerpc:e500)

(gdb) set architecture powerpc:common
The target architecture is assumed to be powerpc:common

> (gdb)target remote /dev/ttyUSB0
> ...

More explanation can be found here:
http://www.ultsol.com/faq_p311.htm
[I would prefer to reference an explanation on this
mailing list, but I did not find one.]

I hope this solves your problem.

Clive

Dear Clive:

I appreciate your kind comment, but I think I have already accommodate
this by using the latest gdb and cross-compiling it and it starts up in
architecture powerpc:common.

There must be something else going awry here and I wonder what other
things might cause the pc to be unreadable and uncontrollable from gdb.

Charles
