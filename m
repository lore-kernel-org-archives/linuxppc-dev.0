Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71E10B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 05:55:30 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA4Irg1B013678
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2009 13:53:42 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA4ItQTc111866
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2009 13:55:26 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA4ItQn7028409
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2009 13:55:26 -0500
Date: Wed, 4 Nov 2009 13:55:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20091104185519.GI31934@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Please pull the next branch of the 4xx tree to get the following commits.

I have some other things in the middle of being worked that may or may not
make it in time for the next release, so I wanted to get these commits into
your tree now rather than wait.

josh

The following changes since commit 588e050887c5f00a39b056848ea58c8b496beab0:
  Benjamin Herrenschmidt (1):
        powerpc/8xx: Fix build breakage with sparse irq changes

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Mitchell (1):
      powerpc/4xx: Add 16K FIFO size DTS entries on supported platforms

Stefan Roese (1):
      powerpc/44x: Enable 64bit (>= 4GB) memory size in Katmai dts

 arch/powerpc/boot/dts/canyonlands.dts |    2 ++
 arch/powerpc/boot/dts/eiger.dts       |    6 ++++++
 arch/powerpc/boot/dts/glacier.dts     |    6 ++++++
 arch/powerpc/boot/dts/haleakala.dts   |    2 ++
 arch/powerpc/boot/dts/katmai.dts      |   14 +++++++++++---
 arch/powerpc/boot/dts/kilauea.dts     |    4 ++++
 arch/powerpc/boot/dts/makalu.dts      |    4 ++++
 arch/powerpc/boot/dts/redwood.dts     |    1 +
 8 files changed, 36 insertions(+), 3 deletions(-)
