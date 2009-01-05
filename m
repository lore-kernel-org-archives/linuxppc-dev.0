Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id 618C5DE28A
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 20:40:13 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id A69B52E97B2
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 10:25:06 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 960922E97B6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 10:25:06 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id 3089C15187
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 10:25:06 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: [PATCH]: [MPC5200] Add ATA DMA support
Date: Mon, 5 Jan 2009 10:25:05 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B816F@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <fa686aa40812192318m397aab91kcd1684fe80b52d67@mail.gmail.com>
References: <AclPDG6qSkF9cHawTOKR6zBfDIjvgg==>
	<633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
	<fa686aa40812192318m397aab91kcd1684fe80b52d67@mail.gmail.com>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hans, what ATA modes do you see this problem in?  UDMA?  MWDMA?  Or =
does just having the patch applied but still using PIO mode expose the =
problem?


This problem occurs in MWDMA 2 mode.

Happy new year




Mit freundlichen Gr=FC=DFen

Hans Lehmann
Softwareentwicklung

Telefon	+49 (0)2191-67-2520
Fax 	+49 (0)2191-67-703408
e-mail 	hans.lehmann@ritter-elektronik.de



Ritter Elektronik GmbH
Leverkuser Stra=DFe 65
D-42897 Remscheid
www.ritter-elektronik.de

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg  /  USt-ID DE 814009849
