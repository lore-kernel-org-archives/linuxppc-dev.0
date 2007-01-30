Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DE296DE09C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:20:31 +1100 (EST)
Message-ID: <45BFD2B8.8070404@am.sony.com>
Date: Tue, 30 Jan 2007 15:20:24 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] PS3 system bus patches for 2.6.21
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This is an additional small set of patches for 2.6.21 that should apply
on top of my previous set of 16.

Patches 1 & 2 mainly just move code to the ps3 platform directory as requested
by Ben and Christoph.  Patches 3 & 4 fix USB mass storage.

[PATCH 1/4] PS3: Move system bus to platform directory
[PATCH 2/4] PS3: Move vuart declarations to ps3.h
[PATCH 3/4] PS3: Fix DMA scatter-gather
[PATCH 4/4] PS3: Enable USB mass storage

-Geoff
