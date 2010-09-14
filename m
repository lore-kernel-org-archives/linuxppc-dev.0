Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5E782B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 01:14:01 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/10] RapidIO: Set of patches to add Gen2 switches
Date: Tue, 14 Sep 2010 10:59:13 -0400
Message-Id: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of RapidIO patches extends support for standard error recovery
mechanism and adds new IDT Gen2 sRIO switch devices - CPS-1848 and CPS-1616.
Implementation of the standard error-stopped state recovery mechanism (as
defined by the RapidIO specification) is required for the new switches.

The version 2 of this set of patches addresses received comments and fixes
an error notification setup issue found in the idt_gen2.c after the first
version was released.
