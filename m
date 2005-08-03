Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 7611B67E06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 22:54:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 3 Aug 2005 14:47:47 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F8500@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

I gave the MPC885ADS support recently added by Andrei Konovalov=20
a try - but no luck: booting 2.6.13-rc5 with u-boot 1.1.2=20
(tftpboot & bootm) hangs after uncompressing.

Did anybody succeed with this?

Applied were the following patches from patchwork.ozlabs.org:

 * 8xx_cpm_hostalloc
 * all fixes to fec.c

The board boots an 2.4-Kernel just fine. Did i miss some patches=20
for U-Boot?

Best regards,

 Peter
