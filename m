Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 5AF3ADE0A1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 03:07:13 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 0B7EE434004
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 17:04:06 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id T+h1M7Zi4DQu for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 17:04:05 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 43B4E434002
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 17:04:05 +0100 (CET)
Message-ID: <47A88A73.5030101@coritel.it>
Date: Tue, 05 Feb 2008 17:10:27 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Kernel entry point
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

where is the main kernel entry point (the first function/instruction)
for the powerpc arch called by uboot? In kernel 2.6.10 there was the
head_fsl_booke.S (I'm using a booke processor) that it called the
start_kernel function, and now?

Thanks.

Marco
