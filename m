Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 21BD7DE047
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:39:36 +1100 (EST)
Message-ID: <45B81862.1030800@am.sony.com>
Date: Wed, 24 Jan 2007 18:39:30 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 0/14] patches for 2.6.21
Content-Type: text/plain; charset=ISO-8859-1
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

These are all the ps3 patches I have queued for 2.6.21.  Please apply.

[PATCH 1/14] ps3: repository misc fixes
[PATCH 2/14] ps3: repository storage support
[PATCH 3/14] ps3: system bus minor mmio fix
[PATCH 4/14] ps3: fix struct alignment attributes
[PATCH 5/14] ps3: rename interrupt symbols
[PATCH 6/14] ps3: smp interrupt fixes
[PATCH 7/14] ps3: cleanup interrupt bmp routines
[PATCH 8/14] ps3: bind interrupt to cpu
[PATCH 9/14] ps3: add interrupt alloc for outlets
[PATCH 10/14] ps3: get firmware version
[PATCH 11/14] ps3: get av_multi_out params
[PATCH 12/14] ps3: fix gpu_context_allocate hcall
[PATCH 13/14] ps3: remove unneeded header include
[PATCH 14/14] ps3: ps3_defconfig updates
