Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 9F0E6DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 04:14:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Starting the SPI controller in MPC880 blocks the kernel (microcode
	patch needed?)
Date: Thu, 22 Feb 2007 18:14:23 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E682841@aquib01a>
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

I'm using an MPC880 based board with linux-2.6.19, both fec enabled and
the two SMC. I wrote a driver for the 880 SPI controller. As soon as I
write the START command to the spcom register the kernel hangs. Do I
need a microcode patch?=20
=20
Bye,
Antonio.
