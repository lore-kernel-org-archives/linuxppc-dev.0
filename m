Return-Path: <max@stro.at>
Received: from baikonur.stro.at (baikonur.stro.at [213.239.196.228])
	by ozlabs.org (Postfix) with ESMTP id ABFAEDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 11:25:34 +1100 (EST)
Date: Wed, 30 Jan 2008 01:03:37 +0100
From: maximilian attems <max@stro.at>
To: Paul Mackerras <paulus@au.ibm.com>
Subject: ppc64 vecemu compile failure
Message-ID: <20080130000337.GC25253@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

on latest git since driver subsys merge on powerpc64:

arch/powerpc/kernel/built-in.o: In function `fphalf':
vecemu.c:(.toc+0x1360): undefined reference to `devices_subsys'
make[3]: *** [.tmp_vmlinux1] Error 1
