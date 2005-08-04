Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 1425967E9F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 00:22:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 4 Aug 2005 16:03:31 +0200
Message-ID: <47F3F98010FF784EBEE6526EAAB078D119ED1C@tq-mailsrv.tq-net.de>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "Bob Peterson" <bob@acdstar.com>
Cc: achim.machura@berghof.com, linuxppc-embedded@ozlabs.org
Subject: RE: USB + MPC5200 L25R REV 2 OCT0511C
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Bob,

linuxppc-embedded-bounces@ozlabs.org wrote on Thursday, August 04, 2005
3:36 PM:=20
> I've recently been doing some experiments regards USB on our custom
> icecube-like mpc5200 board using the usb-ohci driver, and here's what
> I found:=20
>=20
> 1. Some devices (high speed?) seem to work fine.  I used a USB jump
> drive.=20
> 2. Other devices (low speed?) like USB keyboard and mouse did not.
> 3. Plugging a USB hub into the board allows the same failing devices
>      (kbd & mouse) to work properly (when they are plugged into the
> hub).=20
> 4. The off-the-shelf icecube board behaves the same way, so it's not
>      just our board.

This is most probably an issue with the used USB transceivers. The
Phillips transceivers ISP1106 and ISP1107 are known to not work
correctly with the MPC5200 (with low speed Devices).

The following Transceivers should work:

- Phillips PDIUSBP11
- Fairchild USB1T11AMTC

Regards,
Martin

TQ-Systems GmbH
M=FChlstra=DFe 2, Gut Delling, 82229 Seefeld
Tel. +49 (8153) 93 08-157, Fax +49 (8153) 93 08-7157
martin.krause@tqs.de
www.tq-group.com
