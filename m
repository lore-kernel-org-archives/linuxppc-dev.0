Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2FAAEDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 08:33:23 +1100 (EST)
Message-ID: <473B699C.5040700@anagramm.de>
Date: Wed, 14 Nov 2007 22:33:16 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: 85xx Device tree problems: e0024520:02 not found
References: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>	<473A0A1B.3020302@anagramm.de>	<f87675ee0711141118h3281b79dpaa49c6da7d57d891@mail.gmail.com>
	<473B5940.2090306@anagramm.de>
In-Reply-To: <473B5940.2090306@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Robert!

Just one more short note...
My good - vs. - bad dmesg output:

good 2.6.21-rc5-git:
 > Gianfar MII Bus: probed
 > eth0: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
 > eth0: Running with NAPI enabled
 > eth0: 256/256 RX/TX BD ring size
 > eth1: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
 > eth1: Running with NAPI enabled
 > eth1: 256/256 RX/TX BD ring size
 > eth2: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
 > eth2: Running with NAPI enabled
 > eth2: 256/256 RX/TX BD ring size
 > Marvell 88E1101: Registered new driver
 > Marvell 88E1111: Registered new driver
 > Marvell 88E1145: Registered new driver
(I've wiped out my MAC)

bad 2.6.24-rc2-git:
< Gianfar MII Bus: probed
< eth0: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
< eth0: Running with NAPI enabled
< eth0: 256/256 RX/TX BD ring size
< eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
< eth1: Running with NAPI enabled
< eth1: 256/256 RX/TX BD ring size
< eth2: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
< eth2: Running with NAPI enabled
< eth2: 256/256 RX/TX BD ring size

The MACs are all 00 here.
The PHY drivers don't get registered.
(What happened to CONFIG_NETDEV_1000 in the newer kernels?)

How is your mileage?
Next round... tomorrow,
regards,

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
