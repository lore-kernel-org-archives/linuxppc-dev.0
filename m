Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BD6E7DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:25:56 +1000 (EST)
Message-ID: <4818F191.5030504@am.sony.com>
Date: Wed, 30 Apr 2008 15:24:17 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/5] PS3 patches for 2.6.26
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This is a small set of PS3 fixup patches for 2.6.26.

  [patch 1/5] POWERPC: Fix slb.c compile warnings
  [patch 2/5] PS3: Add time include to lpm
  [patch 3/5] PS3: Make ps3_virq_setup and ps3_virq_destroy static
  [patch 4/5] PS3: Remove unsupported wakeup sources
  [patch 5/5] PS3: Update ps3_defconfig

-Geoff


-- 
