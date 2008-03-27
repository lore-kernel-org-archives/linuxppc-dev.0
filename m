Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC57ADDFA3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:02 +1100 (EST)
Message-ID: <47EAEC2B.1000006@am.sony.com>
Date: Wed, 26 Mar 2008 17:36:59 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 0/6] PS3 patches for 2.6.26
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul and Jeff,

This is a small set of PS3 patches for 2.6.26.  Patches
1-5 are ready to apply to the powerpc tree.

Patch 6 for the network driver needs an ACK by Jeff.


  [1/6] PS3: Fix unlikely typo in ps3_get_irq
  [2/6] PS3: Add ps3_get_speid routine
  [3/6] PS3: Bootwrapper improvements
  [4/6] PS3: Save power in busy loops on halt
  [5/6] PS3: Sys-manager Wake-on-LAN support
  [6/6] PS3: Gelic network driver Wake-on-LAN support


-Geoff

-- 
