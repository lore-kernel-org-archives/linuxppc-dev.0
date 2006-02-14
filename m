Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id A299367A40
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2006 23:45:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to access uboot environment variables from Linux?
Date: Tue, 14 Feb 2006 04:45:29 -0800
Message-ID: <F795765B112E7344AF36AA9112796415019ECCF6@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>,
	<atul.sabharwal@exgate.tek.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
