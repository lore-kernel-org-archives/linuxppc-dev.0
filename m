Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B64C7DDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 08:26:31 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAJLQSqW021457
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 16:26:28 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAJLQSW0125862
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 14:26:28 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAJLQSjC012721
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 14:26:28 -0700
Date: Mon, 19 Nov 2007 15:26:22 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071119152622.7af35ec3@weaponx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24

to pick up a few bug fixes for 2.6.24.  The AC97 change is fairly
harmless and is required to get AC97 working on Virtex boards.

josh

Joachim Foerster (1):
      [POWERPC] Xilinx: Register AC97 Controller Reference with the platform bus

Jon Loeliger (1):
      [POWERPC] 4xx: Replace #includes of asm/of_platform.h with linux/of_platfo

Josh Boyer (1):
      [POWERPC] 4xx: Use virtual PVR value to init FPU on arch/ppc 440EP

Roel Kluin (1):
      [POWERPC] 4xx: balance ioremap/ioumap calls for Yucca

Valentine Barshak (1):
      [POWERPC] 4xx: UIC add mask_ack callback

 arch/powerpc/platforms/40x/walnut.c  |    3 ++-
 arch/powerpc/platforms/44x/bamboo.c  |    3 ++-
 arch/powerpc/platforms/44x/ebony.c   |    3 ++-
 arch/powerpc/platforms/44x/sequoia.c |    3 ++-
 arch/powerpc/sysdev/uic.c            |   18 +++++++++++++++++-
 arch/ppc/kernel/setup.c              |    7 +++++++
 arch/ppc/platforms/4xx/yucca.c       |    1 +
 arch/ppc/syslib/virtex_devices.c     |   31 +++++++++++++++++++++++++++++++
 8 files changed, 64 insertions(+), 5 deletions(-)
