Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6DB0DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 14:57:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9S3vLhc026098
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 20:57:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9S3vIfx014573
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 22:57:20 -0500 (CDT)
From: Liu Yu <yu.liu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Patch 0/4] math-emu
Date: Tue, 28 Oct 2008 11:50:17 +0800
Message-Id: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
Cc: kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


These patches are related to math-emu.

[Patch 1/4] Fix a fdiv bug of FP math-emu
[Patch 2/4] Update a macro to new version
[Patch 3/4] Remove redundant code
[Patch 4/4] Add SPE/EFP handlers for E500v1/v2 processors
