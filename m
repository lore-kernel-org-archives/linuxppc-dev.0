Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 2471267B8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 01:30:12 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 02 Aug 2006 17:30:10 +0200
From: GSM909@gmx.de
Message-ID: <20060802153010.138770@gmx.net>
MIME-Version: 1.0
Subject: SPI spi_spcom[STR] freeze
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello

I have problem with SPI

When I want to start my SPI transfer by setting 0x80 to my spi_spcom register. 0x80 keeping in this register till I "READ" the SPMODE register. There is also no transfer or any clock on the pins. 
Did anyone had an Idea what this can be ???

my system:
mpc8270 
pm827 from mircosys
linux 2.6.14 with Xenomai 2.1.2
The kernel module with the spi run under the rtdm.

Thx for helping me.
Regards 
Fred

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
