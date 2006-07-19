Return-Path: <Chad.Rowan@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id 24A7367B7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 05:39:38 +1000 (EST)
Received: from frasintmail1.it09.biz (frasintmail1.triaton.com [195.203.86.8])
	by mail002.triaton.com (8.13.6/8.13.6) with ESMTP id k6JJBnZ7027608
	for <linuxppc-embedded@ozlabs.org>; Wed, 19 Jul 2006 21:11:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by frasintmail1.it09.biz (Postfix) with ESMTP id DDB8528AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 21:11:54 +0200 (CEST)
Received: from MDCEXC02.na.ops.local (66-194-145-42.static.twtelecom.net
	[66.194.145.42])
	by frasintmail1.it09.biz (Postfix) with ESMTP id 7C91228B1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jul 2006 21:11:54 +0200 (CEST)
Message-ID: <86EC6E02268B3D4BA41C1B0C61FB14E60B3C8335@mdcexc01.na.ops.local>
From: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
To: linuxppc-embedded@ozlabs.org
Subject: export-objs in spi Makefile broke in latest linuxppc_2_4_devel [r
	eposted]?
Date: Wed, 19 Jul 2006 14:13:15 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Shouldn't export-objs in drivers/spi be:

export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5xxx-psc.o \
		   spi-iti5200.o spi-eval.o

instead of:
	
export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5200psc.o \
		   spi-iti5200.o spi-eval.o

I believe the spi-algo-mpc5200psc.o should be spi-algo-mpc5xxx-psc.o,
correct?

Excuse the previous post.  Office, hosed the format.
