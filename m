Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 69843B7BBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 23:24:14 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 6DCA9C0123
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 13:17:28 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Micrel PHY KSZ8001 on MPC5200B FEC
MIME-Version: 1.0
Message-ID: <200910271317.28007.roman.fietze@telemotive.de>
Date: Tue, 27 Oct 2009 13:17:27 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

We would need some help on how to make a Micrel KSZ8001 work on the
MPC5200B FEC using the kernel DENX-v2.6.3[01].

We can already boot the kernel and device tree using TFTP and this PHY
using a recent U-Boot version, so we would need some pointers how to
acomplish that.

Add a proper PHY driver in the drivers/net/phy/ directory?

Modify the DTS? If yes, how? A link to some documentation that's not
already in the kernel sources would already help.

Is it correct, when looking at the sources, that the MPC's FEC driver
switched to the generic PHY driver interface?


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
