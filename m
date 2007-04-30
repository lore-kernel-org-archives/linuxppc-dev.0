Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 15B22DDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:00:46 +1000 (EST)
Message-ID: <463658F8.4050901@am.sony.com>
Date: Mon, 30 Apr 2007 14:00:40 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 0/6] PS3: Patches for 2.6.22
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

Here is a small set of six patches for 2.6.22.  [patch 5/6] makes a
change to arch/powerpc/kernel/irq.c, so needs to be looked at
more closely.

[patch 6/6] PS3: Defconfig updates
[patch 5/6] PS3: Fix system slowdown
[patch 4/6] PS3: Interrupt routine fixups.
[patch 3/6] PS3: Remove duplicate variable assignement
[patch 2/6] PS3: Add DABR support
[patch 1/6] PS3: Remove dev_dbg redefinition in ehci-ps3.c and ohci-ps3.c

-Geoff

-- 
