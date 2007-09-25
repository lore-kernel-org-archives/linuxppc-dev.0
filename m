Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail4.alcatel.fr (smail4.alcatel.fr [62.23.212.167])
	by ozlabs.org (Postfix) with ESMTP id 43C36DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 18:08:23 +1000 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail4.alcatel.fr (ALCANET/NETFR) with ESMTP id l8P7hcDs018925
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 09:43:39 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id JAA09075
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 09:43:38 +0200 (MET DST)
Received: from [172.25.48.83] (frilld0063506 [172.25.48.83])
	by mail (8.8.8p2+Sun/) with ESMTP id JAA09071
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 09:43:38 +0200 (MET DST)
Message-ID: <46F8BBAD.30008@alcatel-lucent.fr>
Date: Tue, 25 Sep 2007 09:41:33 +0200
From: Benjamin ZORES <benjamin.zores@alcatel-lucent.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Linux 2.6.23-rc7 kGDB broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I used to use linux-2.6-kgdb git tree from jwessel to extract kGDB 
related patches
but I now have seen that it has been included in -mm branch.

However, in this branch, kGDB seems to be broken at least on PowerPC
(see http://lkml.org/lkml/2007/9/19/103).
It seems to me that the only reason is due to a missing header file
in include/asm-powerpc/kgdb.h
This file used to be present in kgdb tree (see 
http://git.kernel.org/?p=linux/kernel/git/jwessel/linux-2.6-kgdb.git;a=blob_plain;f=include/asm-powerpc/kgdb.h;hb=kgdb_2.6.22-rc6) 
but is no longer part of the patch.

Is there any reason for that ?
By opposition to what could be said in first LKML thread, adding this 
file is enough to restore kGDB on PowerPC.
I've tested it and it compiles (and work) just fine (and as expected).

Can this file be restored ?

Ben
