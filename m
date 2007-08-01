Return-Path: <keith.mund@clearcube.com>
Received: from mail.clearcube.com (206-127-5-145.fwd.datafoundry.com
	[206.127.5.145]) by ozlabs.org (Postfix) with ESMTP id 97F2DDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 06:30:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC83xx - previous patch to set MBAR
Date: Wed, 1 Aug 2007 15:20:22 -0500
Message-ID: <5EACFDEA24DADE42BF109303D305A8093120A6@MAIL.clearcube.com>
In-Reply-To: <fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
References: <20070801133056.GP3972@stusta.de>
	<fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
From: "Keith Mund" <keith.mund@clearcube.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There was a u-boot 1.1.3 patch for start.S posted on the Freescale LTIB
site:
http://www.bitshrine.org/gpp/u-boot-1.1.3-mpc83xx-cpu-4.patch

The end result simply adds a line to set MBAR to match IMMRBAR.

        lis     r3, CFG_IMMRBAR@h
        ori     r3, r3, CFG_IMMRBAR@l
        stw     r3, IMMRBAR(r4)
+       mtspr   MBAR, r3

Are these patches routinely added to the mainstream u-boot code?=20

Is there any reason why this fix is not a good idea?
