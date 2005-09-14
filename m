Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0B966828F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 16:10:31 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j8EE1Mkn093683
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Sep 2005 14:01:23 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:10:17 +0800
Message-Id: <1126678217.27221.6.camel@banana>
Mime-Version: 1.0
Subject: How to modify MTD driver for MX29LV320ABTC-90?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:
     
          I used 2.4.25 linux at my custom MPC852T.My hardware has 2 *
MX29LV320ABTC, working at 16bit mode.Now i want to used MTD to partion
my flash and JFFS2.I want to know how
to modify MTD for MX29LV320ABTC.

init_tqm_mtd: chip probing count 0
init_tqm_mtd: chip probing count 1
TQM8xxL: No support flash chips found!

PS:My first flash address start at 0x40000000, second is 0x40400000 


Best Regards,
Rober Hsu
