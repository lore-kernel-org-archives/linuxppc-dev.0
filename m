Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "wvmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D95D667A40
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2006 22:29:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to access uboot environment variables from Linux?
Date: Tue, 14 Feb 2006 10:56:27 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9235@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: <atul.sabharwal@exgate.tek.com>, <bgholikh@cisco.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have you not discovered internet search engines?
If you paste the original question ("How could I access the uboot
environment variables from Linux?") into Google, you get the answer as
the first result:
http://www.denx.de/wiki/view/DULG/HowCanIAccessUBootEnvironmentVariables
InLinux

[Continuing the current style of top-posting. Sorry]
Clive
=20
-----Original Message-----
From: linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org
[mailto:linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org] On
Behalf Of atul.sabharwal@exgate.tek.com
Sent: 14 February 2006 01:09
To: bgholikh@cisco.com; linuxppc-dev@ozlabs.org
Subject: RE: How to access uboot environment variables from Linux?


I think you will have to write a program to access and decode u-boot
environment setup format in linux.
If you come across some open source app for this, plz. share with me. It
should be a standard method
but typically a small optimization if you want your main code to be
independent of the boot loader
your are using or if you have common code base which works across
multiple processors/multiple loaders.
=20
--
Atul



From: linuxppc-dev-bounces+atul.sabharwal=3Dtek.com@ozlabs.org
[mailto:linuxppc-dev-bounces+atul.sabharwal=3Dtek.com@ozlabs.org] On
Behalf Of Bizhan Gholikhamseh (bgholikh)
Sent: Monday, February 13, 2006 4:54 PM
To: linuxppc-dev@ozlabs.org
Subject: How to access uboot environment variables from Linux?
=20
All,
How could I access the uboot environment variables from Linux? For
example I would like to access the "serverip"
and change that to a different ip address during run time.
=20
Many thanks in advance,
Bizhan
