Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7211BB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 22:41:47 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5SCKuRc017022
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 08:20:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5SCNskM164402
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 08:41:39 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5S67222020425
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2011 00:07:04 -0600
Date: Tue, 28 Jun 2011 08:07:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20110628120735.GB10237@zod.rchland.ibm.com>
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

A small pull request to add some DTS entries to bind to the new HW RNG
driver for 4xx.

I know Eric has the Bluegene stuff being worked on, and there are
patches from Michal Simek for relocatable kernel support out for RFC.  I
need to review those a bit more closely, so they will probably be pushed
out to the 3.2 merge window.

josh

The following changes since commit dc28518f7d7dfd93cd44edb44f9b8e961f5a5c1b:

  powerpc: Fix doorbell type shift (2011-06-20 11:21:48 +1000)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Josh Boyer (1):
      ppc4xx: Add crypto and RNG entries to Sequoia DTS

Mike Williams (1):
      powerpc/4xx: Update Canyonlands and Glacier boards DTS to add HW RNG support

 arch/powerpc/boot/dts/canyonlands.dts |    5 +++++
 arch/powerpc/boot/dts/glacier.dts     |    8 +++++++-
 arch/powerpc/boot/dts/sequoia.dts     |   12 ++++++++++++
 3 files changed, 24 insertions(+), 1 deletions(-)
