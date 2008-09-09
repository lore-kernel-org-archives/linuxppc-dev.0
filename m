Return-Path: <schardt@team-ctech.de>
Received: from www2.team-ctech.de (www2.team-ctech.de [62.146.20.117])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F751DE006
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 01:43:20 +1000 (EST)
Received: from static-87-79-236-23.netcologne.de ([87.79.236.23]
	helo=[192.168.6.21]) by www2.team-ctech.de with esmtpa (Exim 4.69)
	(envelope-from <schardt@team-ctech.de>) id 1Kd5N1-0001qy-C6
	for linuxppc-embedded@ozlabs.org; Tue, 09 Sep 2008 17:43:11 +0200
Message-ID: <48C69990.9040604@team-ctech.de>
Date: Tue, 09 Sep 2008 17:43:12 +0200
From: Georg Schardt <schardt@team-ctech.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Device Tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

im searching for informations about the flatten device trees. the only 
thing i know is, that the device tree is a kind of data-structure which 
the bios or bootloader gives to the operation system.

until now, i boot linux with uboot without a device tree, but newer 
kernel wants a devicetree, i think ??
i use a virtex4 board with an integrated powerpc

how can i create the device tree file ?
how must the linux kernel be configured ?
is there a good internet page with informations ?


thanks
regards
georg
