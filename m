Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B484FDED6F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:10:06 +1000 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
	(easymta 1.00 BETA 1) id 1KVpJu-0006Su-Jx
	for linuxppc-dev@ozlabs.org; Wed, 20 Aug 2008 17:09:58 +0200
Date: Wed, 20 Aug 2008 17:09:58 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: boot cuImage on an old u-boot
Message-ID: <20080820150958.GA23294@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have here a mpc8540ads board and a u-boot 1.0.0. I've build the
defconfig for the board and I tried to boot the genarated
cuImage.mpc8540ads image. After the bootm command I see just

|8540> bootm 1000000
|## Booting image at 01000000 ...
|   Image Name:   Linux-2.6.26
|   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
|   Data Size:    1232711 Bytes =  1.2 MB
|   Load Address: 00400000
|   Entry Point:  004005ac
|   Verifying Checksum ... OK
|   Uncompressing Kernel Image ... OK
|

I don't see the device tree fixups printfs, so crash happend quite
early. Anyone an idea what I could have done wrong?

Sebastian
