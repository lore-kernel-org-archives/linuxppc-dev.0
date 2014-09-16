Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 802FB1A002C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:37 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Tue, 16 Sep 2014 10:25:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4815D357804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8G0QrRL32374956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:26:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8G0PXJG015355
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:34 +1000
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc/pseries: RTAS mobility fixes
Date: Tue, 16 Sep 2014 10:25:26 +1000
Message-Id: <1410827128-6876-1-git-send-email-cyril.bur@au1.ibm.com>
Cc: Cyril Bur <cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset addresses endian issues and bugs in device tree update for
ibm,update-nodes and ibm,update-properties RTAS calls.

A subseqent patchset will deal with issues in device tree node addition
(ibm,configure-connector RTAS call) as well as more robust handling of
deleting critical device tree nodes.

Cyril Bur (2):
  powerpc/pseries: fix endian bugs in mobility RTAS calls
  powerpc/pseries: fix bugs in RTAS mobility code

 arch/powerpc/platforms/pseries/mobility.c | 143 +++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 54 deletions(-)

-- 
1.9.1
