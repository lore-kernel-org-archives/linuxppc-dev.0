Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id 9D95CDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 01:45:23 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 99C5C2E97BC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 15:45:18 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 8CEB62E97B2
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 15:45:18 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id 697C892
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 15:45:18 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: [PATCH]: [MPC5200] Add ATA DMA support
Date: Tue, 25 Nov 2008 15:45:18 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Tim Yamin" <plasm@roo.me.uk>, "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tim, Grant,

just an info.

Very often the Bestcomm-FEC crashed without any error logs if I initiate =
a transaction over FEC and save the file to disk (I rememeber I have =
read something like that). A restart of FEC don't work.  =20
But no I figured out, if I connect to the other ethernet port of our =
board (natsemi) the FEC will awake to life again, if I initiate a new =
transaction over natsemi. This seems a little oddly to me.

Cheers =20

Mit freundlichen Gr=FC=DFen

Hans Lehmann
Softwareentwicklung

Telefon	+49 (0)2191-67-2520
Fax 	+49 (0)2191-67-703408
e-mail 	hans.lehmann@ritter-elektronik.de

=20

Ritter Elektronik GmbH
Leverkuser Stra=DFe 65
D-42897 Remscheid
www.ritter-elektronik.de <http://www.ritter-elektronik.de/start.html>=20

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg  /  USt-ID DE 814009849
