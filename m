Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 0/3] powerpc: HW filtering of breakpoint for
 user/kernel/hypervisor events
Date: Fri,  7 Sep 2012 17:24:55 +1000
Message-Id: <1347002698-7341-1-git-send-email-mikey@neuling.org>
In-Reply-To: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
References: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is in response to Geerts concerns. 

Only posting last two patches again as first 3 are already in benh's next
tree.

Added another patch to cleanup some #defines that we can now remove

Michael Neuling (3):
  powerpc: Rework set_dabr so it can take a DABRX value as well
  powerpc: Dynamically calculate the dabrx based on
    kernel/user/hypervisor
  powerpc: cleanup old DABRX #defines

 arch/powerpc/include/asm/debug.h         |    2 +-
 arch/powerpc/include/asm/hvcall.h        |    5 -----
 arch/powerpc/include/asm/hw_breakpoint.h |    3 ++-
 arch/powerpc/include/asm/machdep.h       |    3 ++-
 arch/powerpc/include/asm/processor.h     |    1 +
 arch/powerpc/include/asm/reg.h           |    3 +++
 arch/powerpc/kernel/hw_breakpoint.c      |   19 +++++++++++++------
 arch/powerpc/kernel/process.c            |   14 +++++++-------
 arch/powerpc/kernel/ptrace.c             |    3 +++
 arch/powerpc/kernel/signal.c             |    2 +-
 arch/powerpc/platforms/cell/beat.c       |    4 ++--
 arch/powerpc/platforms/cell/beat.h       |    2 +-
 arch/powerpc/platforms/ps3/setup.c       |   10 +++++++---
 arch/powerpc/platforms/pseries/setup.c   |   14 +++++++++-----
 arch/powerpc/xmon/xmon.c                 |    4 ++--
 15 files changed, 54 insertions(+), 35 deletions(-)

-- 
1.7.9.5
