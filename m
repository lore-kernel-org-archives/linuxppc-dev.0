Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 368C12C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:22:26 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH 0/2] powerpc/math-emu: two patches for the emulation of the
 FPU unimplemented instructions
Date: Thu, 11 Jul 2013 20:21:53 +0800
Message-ID: <1373545315-9219-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches are for the emulation of the FPU unimplemented instructions.
The first is just a bit optimization for the FPU state flush.
The second is requested by Scott.

Kevin Hao (2):
  powerpc/math-emu: move the flush FPU state function into do_mathemu
  powerpc/math-emu: keep track of the instructions unimplemented by FPU

 arch/powerpc/kernel/traps.c  |  9 --------
 arch/powerpc/math-emu/math.c | 53 +++++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 25 deletions(-)

-- 
1.8.1.4
