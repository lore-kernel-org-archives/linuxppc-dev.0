Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5663068017
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:57:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 11:57:04 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859417@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
> Sent: Tuesday, August 09, 2005 11:41
> Hmm, if I'm correct this clock drift (130ppm) should be=20
> handled easily=20
> by NTPD without stepping clock but with slewing. This is why NTPD=20
> exists in the first place, so I don't see any reason to change=20
> the kernel.

NTPD probably handles this correct, but I would like the time to be
correct anyways. In our case we might not always have access to a ntpd
server, and our input clock is very accurate to begin with.
