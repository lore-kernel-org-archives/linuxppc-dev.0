Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 0/3] powerpc/perf BHRB fixes
Date: Tue, 14 May 2013 14:44:55 +1000
Message-Id: <1368506698-22400-1-git-send-email-mikey@neuling.org>
In-Reply-To: <9911.1368179795@ale.ozlabs.ibm.com>
References: <9911.1368179795@ale.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v3 changes:
  Don't break 32 bit

v2 changes: 
  add __user to ptr to __get_user_inatomic()

Michael Neuling (3):
  powerpc/perf: Move BHRB code into CONFIG_PPC64 region
  powerpc/pmu: Fix order of interpreting BHRB target entries
  powerpc/perf: Fix setting of "to" addresses for BHRB

 arch/powerpc/perf/core-book3s.c |  280 ++++++++++++++++++++++-----------------
 1 file changed, 159 insertions(+), 121 deletions(-)

-- 
1.7.10.4
