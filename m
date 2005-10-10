Return-Path: <a.hawkins@cabletime.com>
Received: from anchor-fallback-93.mail.demon.net
	(anchor-fallback-93.mail.demon.net [194.217.242.93])
	by ozlabs.org (Postfix) with ESMTP id 570376842B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 21:03:21 +1000 (EST)
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:3839 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S828687AbVIMKFf (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Tue, 13 Sep 2005 11:05:35 +0100
Received: from mailgate.cabletime.com ([80.177.138.66] helo=cabletime.com)
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1EF7f5-000NRA-2x
	for linuxppc-embedded@ozlabs.org; Tue, 13 Sep 2005 10:05:13 +0000
Received: from adh.cabletime.com ([191.53.51.21] helo=adh)
	by cabletime.com with smtp (Exim 3.35 #1 (Debian))
	id 1EF7es-0004jm-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 13 Sep 2005 11:04:58 +0100
From: "Andy Hawkins" <a.hawkins@cabletime.com>
To: <linuxppc-embedded@ozlabs.org>
Message-ID: <002a01c5b84a$99881450$153335bf@cabletime.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Help with PCMCIA Compact Flash on PPC405 EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Mon, 10 Oct 2005 11:03:23 -0000

Hi,

We're using a PCMCIA adapter (TI PCI1510 PC card Cardbus Controller) on a
PPC 405 EP running a Montavista 2.4.20 kernel. The PCMCIA adapter works
correctly, as we can insert a hard disk into there, and successfully mount
and access it.

However, when we insert a Compact Flash adapter (Lexar Media PC Card Adapter
part 2076-C) with a Compact Flash card (PNY 1 Gig CompactFlash EMET1034) the
whole board appears to go into a tight loop. I've stepped the code using a
BDI, and it appears that the PCMCIA adapter is continually generating
interrupts, but the handler routine in yenta.c thinks that there's nothing
to do.

Removing the CF card will bring the system back to life. It appears to be
generating something like 350,000 interrupts every second while the card is
inserted.

Can anyone offer any advice?

Thanks

Andy
