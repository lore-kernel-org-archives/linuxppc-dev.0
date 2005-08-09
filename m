Return-Path: <jayaprakashns@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 494AB67E9E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 01:07:23 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so1159907rne
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Aug 2005 08:07:23 -0700 (PDT)
Message-ID: <17f142e1050809080053187f40@mail.gmail.com>
Date: Tue, 9 Aug 2005 20:30:27 +0530
From: Jayaprakash Shanmugam <jayaprakashns@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: open() returns 0.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,

  I have a 8270 based board running Linux 2.6.  I am using the i2c
available on chip to read / write a i2c mux connected to it.  When I
open the i2c device, it returns 0 (which shouldnt be) instead of the
file descriptor.   The /proc/devices shows the i2c driver with major
89 is installed.

10:~# ls -l /dev/i2c-0
lrwxrwxrwx  1 root root 5 Jan  1 02:00 /dev/i2c-0 -> i2c/0

10:~# cat /dev/i2c-0
i2c-dev: i2c-0 reading 4096 bytes.
I2C xfer: read from 0xFFFF, flags 0x0001, 4096 bytes
I2C error: 0x3C04
cat: /dev/i2c-0: Input/output error

Any pointers on what could be wrong ?

Regards,
Jayaprakash.
