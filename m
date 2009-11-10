Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 90BE8B7C69
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 09:45:18 +1100 (EST)
Date: Tue, 10 Nov 2009 20:40:26 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH 0/3] mpc52xx/wdt: re-enable the MPC5200 WDT
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
Message-Id: <1257882026.14374.0@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches merges the MPC5200 WDT into the GPT code, making it
functional again - currently, the MPC5200 GPT code blocks using the WDT.

Additionally, it defines a new OF property as to reserve and/or enable the
WDT during the boot process which may be a requirement for safety-related
(e.g. ISO/EN 61508) applications.

Note that all patches are against Grant Likely's "next" tree.

Cheers, Albrecht.
