Return-Path: <jwboyer@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 18CC0B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 00:07:50 +1000 (EST)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 77017DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 00:07:47 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1478558wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Jul 2009 07:07:45 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 6 Jul 2009 10:07:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20090706140741.GD19829@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Please pull the fixes below from the 4xx tree.  A few Warp platform updates
that should fix the final issues Sean has reported.

thx,
josh

The following changes since commit fd0cca754f3f6756bfdafe500e4f49b1b9e9723f:
  Benjamin Herrenschmidt (1):
        Merge commit 'kumar/next' into merge

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Josh Boyer (1):
      powerpc/44x: Fix build error with -Werror for Warp platform

Sean MacLennan (2):
      powerpc/44x: Update Warp defconfig
      powerpc/4xx: Have Warp take advantage of GPIO LEDs default-state = keep

 arch/powerpc/boot/dts/warp.dts          |    3 +-
 arch/powerpc/configs/44x/warp_defconfig |  200 ++++++++++++++++++++++++-------
 arch/powerpc/platforms/44x/warp.c       |   19 +--
 3 files changed, 166 insertions(+), 56 deletions(-)
