Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C165FDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 18:48:30 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lBD7mPfM004138
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 00:48:25 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lBD7mNTR020703
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 01:48:24 -0600 (CST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org, paulus@samba.org, galak@kernel.crashing.org
Subject: [0/3] Add RapidIO support to powerpc architecture with memory mapping
Date: Thu, 13 Dec 2007 15:58:15 +0800
Message-Id: <11975326982876-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Those patches add RapidIO support to powerpc archiecture with
memory mapping as below:

[1/3] Copy the arch/ppc RapidIO support to arch/powerpc
[2/3] Make the arch/powerpc RapidIO support workable with of-device
      and add memory mapping support.
[3/3] Add the memory mapping support to rionet driver.

Best Regards,
Zhang Wei
