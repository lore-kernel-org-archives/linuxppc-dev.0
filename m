Return-Path: <Marc.Dietrich@ap.physik.uni-giessen.de>
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de
	[134.176.2.3]) by ozlabs.org (Postfix) with ESMTP id B12312BF07
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Dec 2004 00:52:06 +1100 (EST)
Received: from [134.176.2.168] by merkurneu.hrz.uni-giessen.de with ESMTP for
	linuxppc-dev@ozlabs.org; Sun, 26 Dec 2004 14:36:34 +0100
Received: from hermes.hrz.uni-giessen.de (hermes.hrz.uni-giessen.de
	[134.176.2.15])
	by hermes2.hrz.uni-giessen.de (Postfix) with ESMTP id 2A17E4C5CC0
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2004 14:36:52 +0100 (CET)
Received: from [134.176.2.168] by hermes.hrz.uni-giessen.de with ESMTP for
	linuxppc-dev@ozlabs.org; Sun, 26 Dec 2004 14:36:31 +0100
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: linuxppc-dev@ozlabs.org
Date: Sun, 26 Dec 2004 14:35:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
Subject: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I read this thread about booting a PowerStack with newer kernels. Motivated by 
this, I tried to compile a 2.6.10 kernel on my machine (with sym53c825a 
onboard). Sadly, the scsi controller always timeouts during initialisation. I 
had this problem also with the 2.4er kernels, but this was solved in later 
versions (I'm running 2.4.21 now). Now the old driver seem to be removed (or 
merged with sym53c8xx_2) and is only available to MCA and GSC devices.

I also tried to change the irq routings in prep_pci.c like in the latest patch 
with the sym53c8xx_2 driver,
	Slot 12 -> IRQ 15 (sym53c825)
	Slot 15 -> IRQ 11 (dec 21140)
but this didn't helped.

Has anyone a working config file for this machine (PowerStack II 4000/Utah)?

Thanks

Marc
