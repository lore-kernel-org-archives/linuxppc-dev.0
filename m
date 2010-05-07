Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 934D4B7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 May 2010 05:55:11 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o47JmjZ5001476
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 13:48:45 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o47Jst8j141978
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 13:54:58 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o47JssMJ003397
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 May 2010 13:54:55 -0600
Date: Fri, 7 May 2010 15:54:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx (again)
Message-ID: <20100507195453.GN29593@zod.rchland.ibm.com>
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

Two more quick patches from me for -next.  Stefrano's is the Katmai usage of
the reset type change that just went in.  The 460SX PCI-e patch has been sitting
for a while and seems to have been skipped over.

josh

The following changes since commit 1ed31d6db90d51010545921e59d369d2f92b7ac2:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin/master' into next

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Stefan Roese (1):
      powerpc/44x: Add reset-type to katmai.dts

Tirumala Marri (1):
      powerpc/44x: Adding PCI-E support for PowerPC 460SX based SOC.

 arch/powerpc/boot/dts/katmai.dts  |    1 +
 arch/powerpc/boot/dts/redwood.dts |  122 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.c  |  119 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h  |   58 +++++++++++++++++
 4 files changed, 300 insertions(+), 0 deletions(-)
