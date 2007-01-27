Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFFBDDDF58
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:07:47 +1100 (EST)
Message-ID: <45BAC1FC.9030108@am.sony.com>
Date: Fri, 26 Jan 2007 19:07:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 0/16] ps3 patches for 2.6.21 v2
References: <45B81862.1030800@am.sony.com>
In-Reply-To: <45B81862.1030800@am.sony.com>
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

This is second posting of the ps3 patch series I have for 2.6.21.
I tried to address all concerns.  Please apply if acceptable.

[PATCH 1/16] ps3: inform incomplete
[PATCH 2/16] ps3: repository misc fixes
[PATCH 3/16] ps3: repository storage support
[PATCH 4/16] ps3: system bus minor mmio fix
[PATCH 5/16] ps3: fix struct alignment attributes
[PATCH 6/16] ps3: rename interrupt symbols
[PATCH 7/16] ps3: smp interrupt fixes
[PATCH 8/16] ps3: cleanup interrupt bmp routines
[PATCH 9/16] ps3: bind interrupt to cpu
[PATCH 10/16] ps3: add interrupt alloc for outlets
[PATCH 11/16] ps3: fix interrupt bmp
[PATCH 12/16] ps3: remove cpuinfo
[PATCH 13/16] ps3: get firmware version
[PATCH 14/16] ps3: get av_multi_out params
[PATCH 15/16] ps3: remove unneeded header include
[PATCH 16/16] ps3: ps3_defconfig updates

-Geoff
