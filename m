Return-Path: <Luca.Panepucci@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id AD30CDDE42
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 00:17:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: I2c interface on mpc8xx 
Date: Fri, 13 Apr 2007 16:17:05 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E780CEE@aquib01a>
From: "PANEPUCCI LUCA - technolabs" <Luca.Panepucci@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello to all,

I send again my question in plain text format, because I sent the
previous mail in html format by mistake


Hello to all,
=20
I'm using linux 2.6.19 on mpc880. I'm trying to use the lm75 component
connected to the i2c micro interface.
I've inserted the lm75.ko module via insmod command but I haven't found
the legacy directory into the sys filesystem (/sys/devices/legacy/....).
Is it correct that I haven't found it?=20
If it isn't correct, what's the reason?
=20
=20
Thanks in advance
=20
Luca
