Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F13F91A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 14:01:48 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org,
 Aaron Sawdey <sawdey@us.ibm.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Steve Munroe <sjmunroe@us.ibm.com>
Subject: [PATCH v2 0/2] powerpc: powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
Date: Fri, 25 Sep 2015 14:01:38 +1000
Message-Id: <1443153700-15395-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a link stack corruption issue in the VDOS
get_datapage() code and adds a benchmark to test it in future.

v2:
  - Split benchmark out of commit message and put in selftests.
  - Upgrade commit message to essay.
