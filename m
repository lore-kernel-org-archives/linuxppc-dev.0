Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BDB5467B58
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Sep 2006 17:24:06 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Board Bootup and message log
Date: Mon, 18 Sep 2006 09:18:56 +0200
References: <8584FDC94AFF7640B17B8A89B23B19B34F6564@sbsserver.AlphionCorp.local>
	<8584FDC94AFF7640B17B8A89B23B19B34F6568@sbsserver.AlphionCorp.local>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F6568@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609180918.56987.matthias.fuchs@esd-electronics.com>
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

On Saturday 16 September 2006 10:19, Sachin Rane wrote:
> Hi,
>  
> I want to access 'EEPROM' I2C device present on AMCC PPC440GX Evaluation 
bard.
> I have loaded following drivers:
> 1. i2c-core.ko
> 2. i2c-dev.ko
> 3. eeprom.ko
> 4. i2c-ibm_iic.ko
> The entry in the 'sysfs' got created for drivers and devices.

> As per the documentation (/usr/src/linux/Documentation/i2c/dev-interface),
> I2C adapter files gets created under "/dev/i2c-X"are with with major device 
number 89.
>  
> But in my case, the device file is not getting created under '/dev/'.
If you do not have some magic daemons running on your board that will do the 
work you have to create the /dev entries by hand.

Please do not post the same message multiple times. Also attachments are often 
not very welcome on mailing lists.

Matthias
