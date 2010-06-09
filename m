Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19BB71007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 22:09:48 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59C6SQk022138
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 06:06:28 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o59C9gtG258670
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 06:09:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59C9X99011707
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 06:09:33 -0600
Date: Wed, 9 Jun 2010 08:09:31 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20100609120931.GI7801@zod.rchland.ibm.com>
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

Two small fixes that should go into 2.6.35.  Please pull them and shuffle along
to Linus.  I know Linus is leaving for a while at the end of this week, so if
you want me to ask him to pull directly just let me know.

josh

The following changes since commit c2cdf6aba0dfcfb54be646ab630c1bccd180e890:
  Benjamin Herrenschmidt (1):
        powerpc/macio: Fix probing of macio devices by using the right of match table

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Christoph Egger (1):
      powerpc/47x: Correct typo in ifdef guard for 47x

Stefan Roese (1):
      powerpc/44x: Fix UART2/3 interrupt assignment in PPC460EX/GT dts files

 arch/powerpc/boot/dts/canyonlands.dts |    4 ++--
 arch/powerpc/boot/dts/glacier.dts     |    4 ++--
 arch/powerpc/mm/44x_mmu.c             |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
