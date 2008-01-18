Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail71-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 67856DDF05
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:03 +1100 (EST)
Message-ID: <47910C2B.8010408@am.sony.com>
Date: Fri, 18 Jan 2008 12:29:31 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 00/16] PS3 patch collection for 2.6.25
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

I collected together all the unapplied PS3 patches into a series
and re-based them to your for-2.6.25 branch.

Patches #14 and #15 are new, but just code cleanups.  All other patches
have already been reviewed on the ML and have no outstanding comments
or requests.

Please apply for 2.6.25.  If you like, I can re-base or breakup the
series as you like.

-Geoff

[01/16] POWERPC: Add Cell SPRN bookmark register
[02/16] PS3: Make bus_id and dev_id u64
[03/16] PS3: Add ps3_repository_find_device_by_id()
[04/16] PS3: Use the HVs storage device notification mechanism properly
[05/16] PS3: Add repository polling loop to work around timing bug
[06/16] PS3: Kill unused ps3_repository_bump_device()
[07/16] PS3: Refactor ps3_repository_find_device()
[08/16] PS3: Checkpatch cleanups for drivers/ps3/ps3-sys-manager.c
[09/16] PS3: Checkpatch cleanups for drivers/ps3/ps3-vuart.c
[10/16] PS3: Checkpatch cleanups for arch/powerpc/platforms/ps3/repository.c
[11/16] PS3: Add logical performance monitor repository routines
[12/16] PS3: Add logical performance monitor device support
[13/16] PS3: Add logical performance monitor driver support
[14/16] PS3: Vuart change semaphore to mutex
[15/16] PS3: Revove use lpar address workaround
[16/16] PS3: Update ps3_defconfig



-- 
