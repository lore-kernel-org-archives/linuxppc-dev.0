Return-Path: <r.pavon-sierra@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 357F9683ED
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 17:03:54 +1000 (EST)
Received: from SN7855 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.1.3.R)
	with ESMTP id md50000159895.msg
	for <linuxppc-embedded@ozlabs.org>; Wed, 28 Sep 2005 09:03:54 +0200
From: "Roberto Pavon Sierra" <r.pavon-sierra@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 28 Sep 2005 09:02:33 +0200
Message-ID: <000701c5c3fa$99fcd090$8700a8c0@SN7855>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Driver radeonfb for ATI M6 video controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

i try to initialize my video card ATI M6. I installed the driver radeonfb
(kernel linux 2.6.12) for ATI M6 in ppc, but this driver cann´t read the
BIOS-serial flash and takes always default values and not the initialization
values from the BIOS.
Can someone help me with this problem? must i install too a XF86-emulator in
my board (ppc 440GX)? Can i initialize this video card without BIOS?

Best regards,

Roberto
