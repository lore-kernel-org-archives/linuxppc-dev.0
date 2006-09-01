Return-Path: <aleck@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id B164E67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Sep 2006 03:35:53 +1000 (EST)
Received: from [192.168.200.117] (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix-out) with ESMTP id D4A2F8BC0B8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 10:35:52 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by kings.gdatech.com (Postfix-out) with ESMTP id 285A88BC093
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 10:35:52 -0700 (PDT)
Received: from monstertop ([192.168.10.149]) (authenticated)
	by sierra.gdatech.com (8.11.6/8.11.6) with ESMTP id k81HaKP20040
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Sep 2006 10:36:20 -0700
From: "Aleck Lin" <aleck@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Unable to boot kernel 2.6 from u-boot 1.1.4 in Xilinx ML403
Date: Fri, 1 Sep 2006 10:35:42 -0700
Message-ID: <002a01c6cded$0fd88870$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.3.1157101919.2423.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Sorry ,that was a typo, I did use "uImage"

Thanks,

Aleck


> 
> 1. When I directly download zImage.elf to the RAM and boot from there, I
see
...
> 2. When I tried to boot the zImage (sitting in the flash) from u-boot file

When you use U-Boot, you should use the correct image (uImage).

Best regards,

Wolfgang Denk
