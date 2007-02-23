Return-Path: <cem.isik@karel.com.tr>
Received: from [195.214.178.6] (unknown [85.105.64.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "out0.karel.com.tr",
	Issuer "out0.karel.com.tr" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F2C4DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 00:34:38 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by out0.karel.com.tr (Postfix) with ESMTP id 97A77D5C138
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 15:02:02 +0200 (EET)
Received: from mailist.karel.com.tr (mailist [192.168.0.10])
	by out0.karel.com.tr (Postfix) with ESMTP id CD613D5C139
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 15:01:46 +0200 (EET)
Received: from octopus.karel.com.tr (octopus.karel.com.tr [192.168.200.253])
	by mailist.karel.com.tr (8.12.8/8.12.8) with ESMTP id l1ND30GR016275
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Feb 2007 15:03:03 +0200
Received: from orfoz.karel.com.tr (orfoz.karel.com.tr [192.168.2.254])
	by octopus.karel.com.tr (8.13.1/8.13.1) with ESMTP id l1ND3pL3024084
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Feb 2007 15:03:52 +0200
Received: from [192.168.2.108] ([192.168.2.108])
	by orfoz.karel.com.tr (8.13.1/8.13.1) with ESMTP id l1NE2Sm4020812
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Feb 2007 16:02:32 +0200
Message-ID: <45DEE4AD.7010004@karel.com.tr>
Date: Fri, 23 Feb 2007 14:57:17 +0200
From: Cem Vedat ISIK <cem.isik@karel.com.tr>
MIME-Version: 1.0
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: /bin/sh: /sbin/genksyms: not found while compiling 2.4.26
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

I'm using Kubuntu to compile 2.4.26 kernel with mpc885ads support. After
#make menuconfig I execute #make dep, I get,

| /sbin/genksyms  -k 2.4.26 >
/opt/kernel/linux-2.4.26/include/linux/modules/pqpic.ver.tmp
/bin/sh: /sbin/genksyms: not found

kind of errors. Is there an alternative to genksyms? Since, I'm able to
configure and build 2.4.25 kernel without any errors.

Regards,
Cem Vedat ISIK
cem.isik@karel.com.tr

PGP Key ID = 0×6D7B02F7
fingerprint = 8C34 144C 999A 917C 8EA0 1199 C136 C114 6D7B 02F7

-----------------------------------------------------------------------
Bu mesaj Karel MailScanner ile tehlikeli icerik ve virus kontrolunden gecirilmistir.
KAREL A.S. - Bilgi Teknolojileri Bolumu
This message has been scanned for viruses and dangerous content by Karel MailScanner, and is believed to be clean.
KAREL A.S. - Information Technologies Department
