Return-Path: <nreddy@netenrich.com>
Received: from mail.netenrich.com (mail.netenrich.com [204.13.82.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A92C2679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 21:54:15 +1000 (EST)
Message-ID: <34616.61.95.208.2.1147781429.squirrel@61.95.208.2>
Date: Tue, 16 May 2006 05:10:29 -0700 (PDT)
Subject: "Need help to configure DNS on the Embedded system"
From: nreddy@netenrich.com
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

Hi All,

 I am working on implementing wget future on my Embedded device.
 So i downloaded free wget sources (version 1.10.2) and compiled for my
system.
My system is walnut based one(IBM405EP processor). But wget is working if
i specify IP when i try to download some file from my support site(i gave
IP of support site), but when i specify like www.support.netenrich.com, it
is not able to resolve.

 I Modified /etc/resolve.conf, but still it says unable to resolve .

 I am using MontaVista Linux Kernel 2.4.20.

can some one let me know how to configure the DNS on any embedded systems.
I have gone through some of the meterial available on the net, but could
not resolve it.

Thanks in Advance,
Nagi Reddy.C
