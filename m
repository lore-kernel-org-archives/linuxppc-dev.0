Return-Path: <kenneth.fairweather@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3B9F9DDF38
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 03:11:48 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l22GBiRs018542
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Mar 2007 09:11:44 -0700 (MST)
Received: from r37065-11-010137013014.ea.freescale.net
	(R37065-11-010137013014.ea.freescale.net [10.137.13.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l22GBh7T027873
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Mar 2007 10:11:44 -0600 (CST)
From: Kenneth Fairweather <kenneth.fairweather@freescale.com>
To: linuxppc-embedded@ozlabs.org
Subject: errors compiling 2.6.20 for mpc866ads
Date: Fri, 2 Mar 2007 16:25:14 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703021625.14661.kenneth.fairweather@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Compiling a vanilla 2.6.20 kernel and applying Vitaly Bordug's 7 patches (21st 
Jan'07) for mpc866_ads_defconfig gives compiler errors:

  LD      arch/powerpc/platforms/8xx/built-in.o
  LD      arch/powerpc/platforms/built-in.o
  CC      drivers/net/fs_enet/fs_enet-main.o
linux-2.6.20/drivers/net/fs_enet/fs_enet-main.c: In function `setup_immap':
inux-2.6.20/drivers/net/fs_enet/fs_enet-main.c:1139: error: `IMAP_ADDR' 
undeclared (first use in this function)

Are these patches for 2.6.20 kernel, and/or are there other patches required? 
should I still be using ppc branch?

Also, tried to grab Vitaly's git tree, but it is failing on http (I'm behind a 
firewall). Is this a known problem?

cg-clone http://source.mvista.com/git/linux-2.6-vitb.git
defaulting to local storage area
Fetching head...
cg-fetch: unable to get the HEAD branch


Kenny
