Message-ID: <3980846B.5B9ADB0B@lucent.com>
Date: Thu, 27 Jul 2000 12:50:19 -0600
From: Steven Tarr <tarr@lucent.com>
MIME-Version: 1.0
To: LINUXPPC <linuxppc-embedded@lists.linuxppc.org>, support@mvista.com
Subject: initrd >4MB?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How does one make a initrd that is greater than 4MB?
A quick look at the configuration autoconf.h has a parameter
to specify the ramdisk size, but I can't find where it is
used. I look in drivers/block/rd.c  and there is a hardcoded
variable there of 4096.  Looks like there is support for
using 2 or more /dev/ram* as a logical ramdisk, but I
can't find any documentation on how to do that.

Thanks --
tarr

--
Steve Tarr
tarr@lucent.com
303-538-4056

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
