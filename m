Return-Path: <Paul.CHAVENT@alyotech.fr>
Received: from criltechnology.com (mail-out.criltechnology.com
	[195.115.177.11]) by ozlabs.org (Postfix) with ESMTP id B12A6DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 03:05:01 +1000 (EST)
Received: from cril01.criltechnology.net by criltechnology.com
	(MDaemon PRO v9.6.0) with ESMTP id md50000131416.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 06 Sep 2007 18:53:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Support a new platform in arch/ppc or in arch/powerpc ?
Date: Thu, 6 Sep 2007 18:53:54 +0200
Message-ID: <631F24C6E5322142A5BDEFA2E8518080297862@tls01.criltechnology.net>
From: "CHAVENT Paul" <Paul.CHAVENT@alyotech.fr>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good morning.

I would like to port a bsp (for the motorola MVME5500 sbc) to the =
current (2.6.22.6) kernel.

Should i implement it in arch/powerpc ?

If i should do it in arch/powerpc, can i copy some code i need in =
arch/ppc ? For example, with kernel 2.6.18.1 i used =
arch/ppc/syslib/todc_time and arch/ppc/syslib/pci_auto, but perhaps i =
don't need it anymore ?

Is there any recommandation for arch/powerpc implementation ?

Thank you.

Paul.
