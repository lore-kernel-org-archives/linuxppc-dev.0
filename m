Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] powerpc/ptrace: hw breakpoint book3s repost and cleanups
Date: Mon, 29 Oct 2012 12:13:14 +1100
Message-Id: <1351473197-27426-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a repost of K.Prasad hw breakpoint support for book3s and some
other junk I found along the way.

K.Prasad (1):
  powerpc/hw-breakpoint: Use generic hw-breakpoint interfaces for new
    PPC ptrace flags

Michael Neuling (2):
  powerpc/ptrace: Fix spelling mistake
  powerpc/ptrace: Remove unused addr parameter in ppc_del_hwdebug()

 Documentation/powerpc/ptrace.txt |   16 +++++++
 arch/powerpc/kernel/ptrace.c     |   86 ++++++++++++++++++++++++++++++++++----
 2 files changed, 94 insertions(+), 8 deletions(-)

-- 
1.7.9.5
