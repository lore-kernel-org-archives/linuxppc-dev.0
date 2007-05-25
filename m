Return-Path: <geert@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E15B3DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 18:37:29 +1000 (EST)
Message-Id: <20070525083607.784351000@sonycom.com>
Date: Fri, 25 May 2007 10:36:07 +0200
From: Geert.Uytterhoeven@sonycom.com
To: linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [patch 0/7] RFC: PS3 Storage Drivers
Sender: Geert Uytterhoeven <geert@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi,

This is the first submission of the new PS3 storage drivers:
 [1] ps3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
 [2] ps3: Extract ps3_repository_find_bus()
 [3] ps3: Storage Driver Core
 [4] ps3: Storage Driver Probing
 [5] ps3: Disk Storage Driver
 [6] ps3: ROM Storage Driver
 [7] ps3: FLASH ROM Storage Driver

They are submitted purely for review, as some of the underlying infrastructure
code hasn't been submitted yet (for reference, you can take a look at Geoff's
git tree (git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git)).

Thanks for you comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
