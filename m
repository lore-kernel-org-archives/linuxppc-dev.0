Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3F0CDDF8C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 02:25:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: I2C support for 8541
Date: Mon, 30 Apr 2007 09:25:28 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F9@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F4@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Assuming I have the external IRQ's understood, the next issue is the
hardware clock on our board with the linux-2.6.17.11 kernel. We are
using a "DS1338U", which is an I2C RTC.

I am trying to identify the relevant source for the 8541/8555 I2C
interface in the source base which reads/writes I2MOD, I2ADD, II2BRG,
I2COM, I2CER & I2CMR.

I can find a few references to MPC85xx_CPM_I2C in
../syslib/mpc85xx_devices.c, but nothing close in drivers/i2c/...

Can someone help me understand the completeness of the I2C source in the
2.6.17.11 kernel, please.

Charles Krinke
