Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8D86DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 05:17:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9SIHjel025465
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 11:17:51 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m9SIHir6018854
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 13:17:45 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Remove map_/unmap_single() from dma_mapping_ops
Date: Tue, 28 Oct 2008 13:17:44 -0500
Message-Id: <1225217864-31280-1-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <200810281738.14104.markn@au1.ibm.com>
References: <200810281738.14104.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

| 
| Now that all of the remaining dma_mapping_ops have had their
| map_/unmap_single
| functions updated to become map/unmap_page functions, there is no need
| to have
| the map_/unmap_single function pointers in the dma_mapping_ops.
| 
| So, take this opportunity to remove them and also remove the code that
| does
| the checking for which set of functions to use.
| 
| Signed-off-by: Mark Nelson <markn@au1.ibm.com>

LGTM; test-built and booted an 8641 to double check.  I'm glad to see
the hackery removed. 

Acked-by: Becky Bruce <becky.bruce@freescale.com>

Cheers,
-Becky
