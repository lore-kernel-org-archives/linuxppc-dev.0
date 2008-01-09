Return-Path: <Jogi95@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	by ozlabs.org (Postfix) with ESMTP id A706BDE053
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 08:30:02 +1100 (EST)
Date: Wed, 09 Jan 2008 22:29:59 +0100
Message-Id: <524587219@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux for ml310
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi 

I switched "Xilinx uartlite serieal port support" and "Support for console on Xilinxuartlite serialport" on and "8250/16550 and compatible serial support" off, in the kernel config.
Then I removed the things I added in the xparameters.h and compiled successfully.
But I have yet a few Questions:

- What would you recommend to use? UART-Lite or a 16550 serial port. Can I get a console running on the RS232 Port of the Board with both possibilities?

- Can you recommend anything for my next steps to get an running linux (rootfs usw.)? So far I oriented myself on the Klingauf page, but I think it is perhaps not the best one because its too old and some things will probably not work the way he did it anymore.

Greez & Thanks
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
