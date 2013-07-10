Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8040E2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 11:44:20 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc/math-emu: two minor cleanup patches for math.c
Date: Wed, 10 Jul 2013 09:43:41 +0800
Message-ID: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
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

Just remove some dead or unneeded codes in math.c. No function change.

Kevin Hao (2):
  powerpc/math-emu: remove the dead code in math.c
  powerpc/math-emu: remove the unneeded check for CONFIG_MATH_EMULATION
    in     math.c

 arch/powerpc/math-emu/math.c | 46 --------------------------------------------
 1 file changed, 46 deletions(-)

-- 
1.8.1.4
