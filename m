Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA2C71A1A2E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:08:39 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so208985051pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:08:37 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ux3sm55304740pac.18.2015.11.30.21.08.35
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 30 Nov 2015 21:08:36 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] selftests/powerpc: Transactional Memory
Date: Tue,  1 Dec 2015 16:08:21 +1100
Message-Id: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is reliant on the following patch series:
- selftests/powerpc by Michael Ellerman 
- selftests/powerpc by Michael Neuling 
- powerpc/tm by Michael Neuling 

Rashmica Gupta (3):
  selftests/powerpc: Standardise TM calls
  selftests/powerpc: Add test for forking inside transaction
  selftests/powerpc: Add in check for TM

 tools/testing/selftests/powerpc/tm/.gitignore      |  1 +
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 tools/testing/selftests/powerpc/tm/tm-fork.c       | 41 ++++++++++++++++++++++
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c | 18 +++++-----
 .../testing/selftests/powerpc/tm/tm-signal-stack.c |  4 +--
 5 files changed, 53 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c

-- 
2.5.0
