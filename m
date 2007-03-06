Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 65DB9DDE34
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 19:36:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help Melinda with a 2.6 spi driver for mpc875!
Date: Tue, 6 Mar 2007 09:36:46 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E683638@aquib01a>
In-Reply-To: <20070305200937.70365.qmail@web63012.mail.re1.yahoo.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "melinda develey" <melinda.develey70@yahoo.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>I attached a driver for the SPI controller of MPC875 that I'm
developing. It's not yet complete, actually, in >the mpc8xx_transfer ()
method simply tries to transmit 3 bytes (the SPI controller is looped)
and thus I=20

Hi Melinda,

I saw that you are using __pa() to convert virtual to physical addresses
for the rx and tx buffers. I had a lot of problems with it. I used it in
2.4 but now it seems to have strange effects.

Bye,
Antonio.
