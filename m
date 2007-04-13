Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id D1410DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 05:55:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux 2.6 and uboot
Date: Fri, 13 Apr 2007 15:55:46 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095293284D7@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

Is there any correlation between the version of U-boot to use on a board
and the version of the Linux kernel you plan to use? Current I'm running
U-boot 1.1.2 with kernel 2.4.26 on my MPC85xx board, but i'm trying to
migrate to the latest 2.6 kernel. I am getting a kernel hang at boot
when it registers socket family 17, so I was wondering if it might have
to do with u-boot before exploring the debug route.
=20
Clinton Thomas
