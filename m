MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: how to read/write registers of CPU or Device from user space
Date: Mon, 12 Jan 2004 08:48:59 -0500
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B437137E@tarpon.mangrovesystems.com>
From: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
To: <zjzhou@newrocktech.com>, <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>From user space access, use mmap.



Regards,
 
Muhammad Sarwar
Mangrove Systems Inc.


-----Original Message-----
From: John Zhou [mailto:zjzhou@newrocktech.com]
Sent: Sunday, January 11, 2004 9:20 PM
To: linuxppc-dev@lists.linuxppc.org
Subject: how to read/write registers of CPU or Device from user space


Hi, all,

when debugging kernel or driver, we need to read/write registers of CPU and devices. I wanna use /dev/mem to do, is it possible? if need to do others things? is it better to write a driver for read/write CPU/device's registers by myself?

Do you have any good advice?

Thanks in advance!
John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
