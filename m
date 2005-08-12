Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0491267EB7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 09:06:39 +1000 (EST)
Received: from 216-110-51-8.gen.twtelecom.net ([216.110.51.8] helo=[127.0.0.1])
	by www65.dixiesys.com with asmtp (Exim 4.24) id 1E3i9D-0005Uq-Jz
	for linuxppc-embedded@ozlabs.org; Fri, 12 Aug 2005 17:37:08 -0500
Message-ID: <42FD248D.2040508@orkun.us>
Date: Fri, 12 Aug 2005 17:37:01 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Multiple I2C busses on PPC405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a working embedded linux on Cogent CSB472 board (PPC405GP) 
currently based on off 2.4.31. We are already using the I2C bus on 
PowerPC using hardware I2C driver (IBM IIC I2C Interface) at Fast 
(400khz) mode.

We need to add support for yet another (slow) I2C bus with PPC405 being 
the master and I'm looking at implementing bit bang interface using GPIO 
pins.

What is the best way to get this going? I am looking at modifying the 
bit bang driver (PPC_405_I2C_Algorithm?) for the I/O pins I'll use. 
Anyone has done something similar. I appreciate all the advice I can get.

Best Regards,
Tolunay
