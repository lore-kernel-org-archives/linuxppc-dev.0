Return-Path: <lk99336@pobox.sk>
Received: from bobek.mail-atlas.net (unknown [193.86.85.7])
	by ozlabs.org (Postfix) with ESMTP id 01F1667D02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 07:08:00 +1000 (EST)
Received: from bobek ([127.0.0.1]) by bobek.mail-atlas.net
	for linuxppc-embedded@ozlabs.org; Thu, 24 Aug 2006 15:12:54 +0200
From: "=?windows-1250?B?TGFkaXNsYXYgS2xlbm92aeg=?=" <lk99336@pobox.sk>
To: linuxppc-embedded@ozlabs.org
Message-ID: <99de7cba0d63488089aa1add47109fb9@pobox.sk>
Date: Thu, 24 Aug 2006 15:12:54 +0200
Subject: communication with i2c client
MIME-Version: 1.0
Content-type: text/plain; charset=windows-1250
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I've create an i2c client and my questions is how to access it from use=
rspace=2E This client is sitttng on adapter that  I was able to access =
via /dev interface=2E After the client were successfuly loaded and dete=
cted,
ioctl(fd,I2C_SLAVE,=2E=2E=2E) and read/write functions didn't work and =
 error messages like "device busy" or "ioctl error" have occured=2E Als=
o my debug messages from i2c client didn't arise when I am accessing=20
device only adapter's=2E
How to (standardly) access a an i2c client?=20
Do I need to create an ioctl interface or exports some helper function =
for access it from user space and also from kernel space? =20

regards,
Ladislav=2E
