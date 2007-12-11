Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C78ABDE0A0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 08:37:58 +1100 (EST)
Date: Tue, 11 Dec 2007 22:37:52 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/5] Series to add device tree naming to i2c
In-Reply-To: <20071210183323.12584.88127.stgit@terra.home>
Message-ID: <Pine.LNX.4.62.0712112236480.21672@pademelon.sonytel.be>
References: <20071210183323.12584.88127.stgit@terra.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-533052005-1197409072=:21672"
Cc: Jean Delvare <khali@linux-fr.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-533052005-1197409072=:21672
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 10 Dec 2007, Jon Smirl wrote:
> Respin to split error return fixups out of mpc-i2c to of_platform change
> 
> The following series implements standard linux module aliasing for i2c modules
> It then converts the mpc i2c driver from being a platform driver to an open
> firmware one. I2C device names are picked up from the device tree. Module
> aliasing is used to translate from device tree names into to linux kernel
> names. Several i2c drivers are updated to use the new aliasing. 

Is there any relationship of these patches with commit
cee37ae4071740cb190d1ac4ddb7aa77484aa7b3?

Author: Jean Delvare <khali@linux-fr.org>
Date:   Sat Oct 13 23:56:29 2007 +0200

    i2c: Kill struct i2c_device_id
    
    I2C devices do not have any form of ID as PCI or USB devices have.
    No driver uses "MODULE_DEVICE_TABLE(i2c, ...)" because it doesn't
    make sense. So we can get rid of struct i2c_device_id and the
    associated support code.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Cc: Greg KH <greg@kroah.com>

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-533052005-1197409072=:21672--
