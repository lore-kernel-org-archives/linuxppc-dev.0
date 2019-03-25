Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E85C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7FB207DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7FB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SrJc6QW7zDqMb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 10:37:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.235; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0235.hostedemail.com
 [216.40.44.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SrGm0h7LzDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 10:35:26 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id A18EF837F24C;
 Mon, 25 Mar 2019 23:35:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side88_86497da2c975c
X-Filterd-Recvd-Size: 3154
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf19.hostedemail.com (Postfix) with ESMTPA;
 Mon, 25 Mar 2019 23:35:22 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: Bad file pattern in MAINTAINERS section 'IBM Power Virtual
 Accelerator Switchboard'
Date: Mon, 25 Mar 2019 16:35:21 -0700
Message-Id: <20190325233521.31094-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	7396	IBM Power Virtual Accelerator Switchboard
	7397	M:	Sukadev Bhattiprolu
	7398	L:	linuxppc-dev@lists.ozlabs.org
	7399	S:	Supported
	7400	F:	arch/powerpc/platforms/powernv/vas*
	7401	F:	arch/powerpc/platforms/powernv/copy-paste.h
	7402	F:	arch/powerpc/include/asm/vas.h
-->	7403	F:	arch/powerpc/include/uapi/asm/vas.h

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'arch/powerpc/include/uapi/asm/vas.h':

commit 4dea2d1a927c61114a168d4509b56329ea6effb7
Author: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date:   Mon Aug 28 23:23:33 2017 -0700

    powerpc/powernv/vas: Define vas_init() and vas_exit()
    
    Implement vas_init() and vas_exit() functions for a new VAS module.
    This VAS module is essentially a library for other device drivers
    and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
    In the future this will be extended to add support for user space
    to access the NX coprocessors.
    
    VAS is currently only supported with 64K page size.
    
    Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

 .../devicetree/bindings/powerpc/ibm,vas.txt        |  22 +++
 MAINTAINERS                                        |   8 ++
 arch/powerpc/platforms/powernv/Kconfig             |  14 ++
 arch/powerpc/platforms/powernv/Makefile            |   1 +
 arch/powerpc/platforms/powernv/vas-window.c        |  19 +++
 arch/powerpc/platforms/powernv/vas.c               | 151 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h               |   2 +
 7 files changed, 217 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'arch/powerpc/include/uapi/asm/vas.h' was found
