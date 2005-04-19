Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 7DBF367AC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 23:55:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 19 Apr 2005 09:54:59 -0400
Message-ID: <0007F077BB3476449151699150E8FEA20592CE@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: DMA using PPC440GX DMAC?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To use the DMA Controller on PPC440GX, should I use ppc4xx_set_dma_xxx =
instead of set_dma_xxx? If yes, where are in the kernel are they mapped =
to each other? Any help or pointers.

Thanks in advance.
Sanjay
