MIME-Version: 1.0
Message-ID: <3CA3CB35.000002.20883@mta6>
Date: Fri, 29 Mar 2002 10:02:29 +0800 (CST)
From: "rtpkg" <rtpkg@263.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: =?gb2312?B?VVBNIHdvcmtzIGZvciAxNk1CIFBDIFNEUkFNIGJ1dCBmYWlscyBmb3IgMzJNQiBtZW1vcnk=?=
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have bootrom code (ppcboot) for which I have UPM values with which I
can access the 16MB PC SDRAM okay but for 32MB memory
my bootrom fails to execute out of RAM.

software: Now I have modifyed the AMA and MAMR registers,but it still not work!

Hardware:
My board uses two HY57V281620A SDRAM chips and it's configuration is 4 Banks x 2M x 16bits, 12 rows and 9 column.

MPC SDRAM
=========
A29 A0
A28 A1
A27 A2
A26 A3
A25 A4
A24 A5
A23 A6
A22 A7
A21 A8
A20 A9
GPL_A0 A10
A18 A11

A7 BA0
A8 BA1
OE_GPL_A1 RAS
GPL_A2 CAS
GPL_A3 WE

What do I have to do get 32MB memory going?
Thanks!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
