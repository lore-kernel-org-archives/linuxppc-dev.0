Return-Path: <r.pavon-sierra@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id AEF59682F6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 19:02:51 +1000 (EST)
Received: from SN7855 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.1.2.R)
	with ESMTP id md50000145402.msg
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Sep 2005 10:57:50 +0200
From: "Roberto Pavon Sierra" <r.pavon-sierra@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 19 Sep 2005 10:56:28 +0200
Message-ID: <000301c5bcf8$06b42df0$8700a8c0@SN7855>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ATI Radeon M6-C16h for PPC 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

i´m using on my custom board with PPC 440GX a ATI M6 Mobility Radeon with
kernel 2.6.12.
Now i have to initialize the ati and configure the kernel to support it.
I don´t have the BIOS of ATI for PPC and i like to simulate this BIOS with
U-boot. How can i configure the U-boot for ATI to initialize or how can i
write the programm for ATI- EEPROM BIOS?
must i install a XF86-Simulator on my board?
