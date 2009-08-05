Return-Path: <nst@gersys.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F29D7B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 22:14:05 +1000 (EST)
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3F4F6DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 22:14:05 +1000 (EST)
Message-ID: <4A797655.6060205@gersys.de>
Date: Wed, 05 Aug 2009 14:08:53 +0200
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: ethernet phy attached to wrong driver
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

I'm having trouble with my Ethernet device on a TQM5200 based board with
LXT971 Phy. I'm running U-Boot 2009.03 and a Kernel 2.6.30.

When doing a ping under U-Boot before booting into Linux, Ethernet works
fine in Linux also. Dmesg reads:
[  262.369444] net eth0: Using PHY at MDIO address 0
[  263.265903] net eth0: attached phy 0 to driver LXT971

But if I start Linux without prior use of the fec under U-Boot, Ethernet
is not working in Linux. The wrong drivers seems to be attached to the
phy. Dmesg reads:
[    2.068285] net eth0: Using PHY at MDIO address 0
[    2.964774] net eth0: attached phy 0 to driver Generic PHY
                                                  ^^^^^^^^^^^
Is there a bootarg to tell linux which driver to use? Any ideas what I'm
doing wrong?

Regards
Stefan.
