Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E46FADDE38
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 20:43:19 +1000 (EST)
Message-ID: <46386B36.6040903@anagramm.de>
Date: Wed, 02 May 2007 12:43:02 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: I2C support for 8541
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F9@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F9@MERCURY.inside.istor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Charles!

Charles Krinke schrieb:
> Assuming I have the external IRQ's understood, the next issue is the
> hardware clock on our board with the linux-2.6.17.11 kernel. We are
> using a "DS1338U", which is an I2C RTC.

The I2C RTC drivers have changed in the latest kernels. You might
consider to update to some current 2.6.20+ kernel. On one of my
mpc8540's I get my RTC working right out of the box with an unpatched
vanilla kernel! :-)

Greets,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
