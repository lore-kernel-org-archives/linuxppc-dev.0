Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03881DE036
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 03:15:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ttyS0 ttyS1
Date: Fri, 23 Mar 2007 09:10:51 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B58@MERCURY.inside.istor.com>
References: <3dcf223d9a87.3d9a873dcf22@compuserve.de>
From: "Charles Krinke" <ckrinke@istor.com>
To: <oparz@compuserve.de>,
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

Dear Otto:
=20
You might check that the dev entry points in your root file system for =
/dev/tty, /dev/console, /dev/ttyS0 and /dev/ttyS1 all exist. They must =
be created with mknod and not with mkdir.=20
=20
These are the settings you should see with an 'ls' of the target's root =
filesystem on the host which has created it. All of these entries should =
be character devices as shown by the first bit of the permissions being =
a 'c'.
=20
/dev/console 5 1
/dev/tty 5 0
/dev/ttyS0 4 64
/dev/ttyS1 4 65
=20
Charles Krinke

________________________________

From: linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org on behalf =
of oparz@compuserve.de
Sent: Fri 3/23/2007 3:43 AM
To: linuxppc-embedded@ozlabs.org
Subject: ttyS0 ttyS1



Hello,
i have problems to use ttyS1 on my TQM885 Board.

fd1 =3D open("/dev/ttyS0",O_RDWR);
fd2 =3D open("/dev/ttyS1",O_RDWR);

I have expected to get different filehandles, but
both handles for ttyS0 and ttyS1 are 0!

Any help is very appreciated.

_____________________
Dr. Otto Parzhuber
Munich University of Applied Sciences
Fac. of Precision Engineering





_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
