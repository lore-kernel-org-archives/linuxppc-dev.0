Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0502C1A0633
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 11:16:27 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 0/3] powerpc: Add POWER9 cputable entry
Date: Fri, 19 Feb 2016 11:16:21 +1100
Message-Id: <1455840984-24068-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add CPU table entry for POWER9

v2:
 Updates based on comments from mpe:
  - reuse user features from POWER8
  - remove "Hacked up" from comment
  - gave oprofile name POWER9
  - removed untested power8 machine check hook
  - used defines for tlb init code
  - removed pmu init from setup code
  - added POWER9 to CPU_FTRS_ALWAYS
  - reworded comment on common flush_tlb_* code
  - moved to CPU_FTR_ARCH_300 to be consistent with user bit
