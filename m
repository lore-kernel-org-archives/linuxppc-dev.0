Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 41A92DDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 04:10:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Drivers' probe function calling order
Date: Thu, 3 Jan 2008 17:57:46 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

How can I fix the calling order of two monolithic drivers? I have an spi
driver and a driver for a dataflash, how can I force the system to call
probe function of the spi driver first?
=20
Bye and thanks.
