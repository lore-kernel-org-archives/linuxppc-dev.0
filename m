Return-Path: <kniht@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F08FDE0AF
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:07:49 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6ON7i3D027677
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 19:07:44 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6ON7imO168966
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 17:07:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6ON7hip026997
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 17:07:43 -0600
Received: from [9.12.243.225] ([9.12.243.225])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6ON7flE026856
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 17:07:42 -0600
Message-ID: <48890B3B.8060806@us.ibm.com>
Date: Thu, 24 Jul 2008 18:07:39 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: link failure: file truncated
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just tried to build the latest version from Linus' tree and I am getting 
a link error.

building with the pseries_defconfig

...
  LD      drivers/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 6 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
ld: final link failed: File truncated
make: *** [.tmp_vmlinux1] Error 1


~/src/linus/linux-2.6>cat /etc/SuSE-release 
SUSE LINUX Enterprise Server 9 (ppc)
VERSION = 9
PATCHLEVEL = 3
~/src/linus/linux-2.6>ld --version
GNU ld version 2.15.90.0.1.1 20040303 (SuSE Linux)
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
~/src/linus/linux-2.6>gcc --version
gcc (GCC) 3.3.3 (SuSE Linux)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

~/src/linus/linux-2.6>cat /etc/SuSE-release 
SUSE LINUX Enterprise Server 9 (ppc)
VERSION = 9
PATCHLEVEL = 3



Jon
