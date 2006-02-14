Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 721DA67A3C
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2006 00:40:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to access uboot environment variables from Linux?
Date: Tue, 14 Feb 2006 13:31:24 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9237@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>,
	<atul.sabharwal@exgate.tek.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fw_printenv and fw_setenv _are_ normal userland Linux utilities, which
can be run from the shell command line. If you want your own program
to directly get/set environment variables, just call the appropriate
functions. Read and understand the code.

Clive
[continuing to top-post. sorry]

-----Original Message-----
From: Bizhan Gholikhamseh (bgholikh) [mailto:bgholikh@cisco.com]=20
Sent: 14 February 2006 12:45
To: Jenkins, Clive; atul.sabharwal@exgate.tek.com;
linuxppc-dev@ozlabs.org
Subject: RE: How to access uboot environment variables from Linux?


I am aware of fw_printenv and fw_setenv. But they are uboot utilities,
and I am trying to access the parameter from Linux, what am I missing?
Thanks,
Bizhan=20

-----Original Message-----
From: Jenkins, Clive [mailto:Clive.Jenkins@xerox.com]=20
Sent: Tuesday, February 14, 2006 2:56 AM
To: atul.sabharwal@exgate.tek.com; Bizhan Gholikhamseh (bgholikh);
linuxppc-dev@ozlabs.org
Subject: RE: How to access uboot environment variables from Linux?

Have you not discovered internet search engines?
If you paste the original question ("How could I access the uboot
environment variables from Linux?") into Google, you get the answer as
the first result:
http://www.denx.de/wiki/view/DULG/HowCanIAccessUBootEnvironmentVariables
InLinux

[Continuing the current style of top-posting. Sorry] Clive
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
should be a standard method but typically a small optimization if you
want your main code to be independent of the boot loader your are using
or if you have common code base which works across multiple
processors/multiple loaders.
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
