Return-Path: <li.xu@ge.com>
Received: from ext-ch1gw-5.online-age.net (ext-ch1gw-5.online-age.net
	[64.37.194.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8694E67C54
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 18:10:46 +1000 (EST)
Received: from int-ch1gw-1.online-age.net (int-ch1gw-1 [3.159.232.65])
	by ext-ch1gw-5.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id k7O821bp023549 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 04:02:02 -0400 (EDT)
Received: from cinmlef03.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-ch1gw-1.online-age.net (8.12.9/8.12.3/990426-RLH) with ESMTP id
	k7O824jM016443 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 04:02:05 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: I2C driver for SAA7121 on MPC855 and linux-2.4.25
Date: Thu, 24 Aug 2006 16:02:26 +0800
Message-ID: <84681EC46E2C6347953892915BA5DAB1038FE72F@SHAMLVEM01.e2k.ad.ge.com>
From: "Xu, Li \(GE, Research\)" <li.xu@ge.com>
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

Hi,

I am trying to setup i2c driver for saa7121 on my mpc855 based board
normally the address for saa7121 is 0x88, but when I enable i2c bus
scan, the driver detect it's address is 0x34, so I just stick to 0x34.

Anyway, I can write to saa7121via i2c bus successfully, but I can't =
enable
color bar, so I don't know whether the driver is working properly or =
not?

BTW, I setup I2C driver for SAA7113 and it works fine.

Tim
