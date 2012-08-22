Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH 0/2] powerpc: perf hardware breakpoint fixes
Date: Wed, 22 Aug 2012 17:22:21 +1000
Message-Id: <1345620143-17289-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are a couple of patches for perf for hardware breakpoints.  Along
with https://lkml.org/lkml/2012/8/16/5 hardware breakpoints now work
for me powerpc.  These patches don't depend on that patch though.

Michael Neuling (2):
  powerpc: Remove unessasary ifdefs
  powerpc: Fix null pointer deref in perf hardware breakpoints

 arch/powerpc/include/asm/cputable.h |    2 --
 arch/powerpc/kernel/hw_breakpoint.c |    3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
1.7.9.5
