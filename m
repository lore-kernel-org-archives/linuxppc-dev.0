Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 274B3DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 00:38:30 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 5D9FB434001
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 14:14:36 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2 [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP
	id 15622-10 for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 14:14:27 +0100 (CET)
Received: from nausicaa2.coritel.it (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 0A7DD434002
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 14:14:27 +0100 (CET)
Message-ID: <10602.129.192.97.5.1195132467.squirrel@nausicaa2.coritel.it>
Date: Thu, 15 Nov 2007 14:14:27 +0100 (CET)
Subject: Kexec on powerpc
From: marco.stornelli@coritel.it
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

I'm using the latest kernel and I need the kexec support for 85xx
processor. When I use the menuconfig with ARCH=ppc and the 85xx and
e500 support, I have the kexec support, but when I use ARCH=powerpc I
haven't it, but I'm selecting the same processor!! Is it a bug in
kconfig? Somebody can explain to me why?

Thanks in advance.

Marco
