Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 1705EDDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 01:13:59 +1000 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 9D47043400E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jun 2008 17:16:21 +0200 (CEST)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id MStwSUh8TErQ for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jun 2008 17:16:20 +0200 (CEST)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 868A143400A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jun 2008 17:16:20 +0200 (CEST)
Message-ID: <485683B7.5030407@coritel.it>
Date: Mon, 16 Jun 2008 17:16:07 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: MPC8641D Msi
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've got a device connected with Pci-express to an mpc8641d_hpcn 
evaluation board (rev. 2.0) and I'm using the latest kernel. This device 
use MSI to generate an interrupt, but it seems possible that the only 
MSI that can be triggered through the standard PCI Express is interrupt 
0. Is there a way to solve it? Some workaround or something like it?

Thanks.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
