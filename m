Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9063667B1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 20:29:24 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Need help to write I2C EEPROM device driver
Date: Wed, 27 Sep 2006 12:21:54 +0200
References: <8584FDC94AFF7640B17B8A89B23B19B34F658F@sbsserver.AlphionCorp.local>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F658F@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609271221.54878.matthias.fuchs@esd-electronics.com>
Cc: Sachin Rane <SRane@alphion.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sachin,

there is already a driver for this part in the kernel 
(drivers/i2c/chips/eeprom.c). 

BTW: to do some simple reads and writes to an I2C EEPROM it is very simple to 
access the EEPROM via read/write/ioctl through /dev/i2c-<x>. No driver - only 
userland code.

Matthias


On Tuesday 26 September 2006 16:34, Sachin Rane wrote:
> Hi,
>  
> I am looking for an information to write a device driver to access EEPROM IC 
M24C02-WBN6.
> The EEPROM IC M24C02-WBN is present on the 'ppc440' evaluation board for 
boot strap purpose.
