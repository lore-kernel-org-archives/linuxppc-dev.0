Return-Path: <brad@heeltoe.com>
Received: from gateway.heeltoe.com (gateway.heeltoe.com [66.134.219.32])
	by ozlabs.org (Postfix) with ESMTP id 00A53DDED8
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 11:19:18 +1000 (EST)
Received: from mwave.heeltoe.com (mwave [192.245.4.20])
	by gateway.heeltoe.com (Postfix) with ESMTP id 72AF311409C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 20:51:13 -0400 (EDT)
Received: from mwave.heeltoe.com (localhost.localdomain [127.0.0.1])
	by mwave.heeltoe.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6M0pDRQ010980
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 20:51:13 -0400
Received: from mwave (brad@localhost)
	by mwave.heeltoe.com (8.12.11.20060308/8.12.11/Submit) with ESMTP id
	l6M0pDsU010976
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 20:51:13 -0400
Message-Id: <200707220051.l6M0pDsU010976@mwave.heeltoe.com>
From: Brad Parker <brad@heeltoe.com>
To: linuxppc-dev@ozlabs.org
Subject: 8247 ether_fcc underruns, but only running kernel 
Date: Sat, 21 Jul 2007 20:51:13 -0400
Sender: brad@heeltoe.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have an 8247 which when running u-boot works fine on ethernet, both 10mb
and 100mb.  It can dhcp and load a kernel.

But when I boot the kernel (2.4 or 2.6) the fcc transmits get an underrun
everytime.  Packets are received fine.  This is on FCC1.

(I'd suspect the tx clock, but ethernet is ok with u-boot.  I double checked
the clock configs under linux.)

Does this ring a bell with anyone?  I started out with rstconf#
grounded, (i.e. default speeds), but i also tried both the cpu and cpm
at 166mhz.  Both acted the same.

I've no doubt got something misconfigured, but what...  I've tried different
BCR settings.

-brad
