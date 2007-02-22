Return-Path: <cem.isik@karel.com.tr>
Received: from [195.214.178.6] (unknown [85.105.64.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "out0.karel.com.tr",
	Issuer "out0.karel.com.tr" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BBC85DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 22:54:52 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by out0.karel.com.tr (Postfix) with ESMTP id BC1FDD5C12E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 13:54:49 +0200 (EET)
Received: from mailist.karel.com.tr (mailist [192.168.0.10])
	by out0.karel.com.tr (Postfix) with ESMTP id 192D9D5C134
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 13:54:39 +0200 (EET)
Received: from octopus.karel.com.tr (octopus.karel.com.tr [192.168.200.253])
	by mailist.karel.com.tr (8.12.8/8.12.8) with ESMTP id l1MBucGR017243
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Feb 2007 13:56:44 +0200
Received: from orfoz.karel.com.tr (orfoz.karel.com.tr [192.168.2.254])
	by octopus.karel.com.tr (8.13.1/8.13.1) with ESMTP id l1MBvSoM017099
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Feb 2007 13:57:28 +0200
Received: from [192.168.2.108] ([192.168.2.108])
	by orfoz.karel.com.tr (8.13.1/8.13.1) with ESMTP id l1MCuHLm026751
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Feb 2007 14:56:18 +0200
Message-ID: <45DD83A9.1060105@karel.com.tr>
Date: Thu, 22 Feb 2007 13:51:05 +0200
From: Cem Vedat ISIK <cem.isik@karel.com.tr>
MIME-Version: 1.0
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: mpc875 support in 2.4.34 kernel
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
I'm trying to compile 2.4.34 kernel for Freescale mpc875 which is a
member of mpc885 family. I've chosen 2.4.34 since it's the latest kernel
of 2.4 family, but some other 2.4.x may be useful.

With
#make ARCH=ppc CROSS_COMPILE=ppc_88x- menuconfig
command, all I get is support for mpc860 family.
Is there a patch or method to compile 2.4 kernel with dual ethernet
enabled mpc875 support?
Thanks in advance, looking forward to hearing from you soon.

-- 
Cem Vedat ISIK
cem.isik@karel.com.tr

PGP Key ID = 0×6D7B02F7
fingerprint = 8C34 144C 999A 917C 8EA0 1199 C136 C114 6D7B 02F7

-----------------------------------------------------------------------
Bu mesaj Karel MailScanner ile tehlikeli icerik ve virus kontrolunden gecirilmistir.
KAREL A.S. - Bilgi Teknolojileri Bolumu
This message has been scanned for viruses and dangerous content by Karel MailScanner, and is believed to be clean.
KAREL A.S. - Information Technologies Department
