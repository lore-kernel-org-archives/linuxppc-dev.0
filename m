Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4330DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 07:31:24 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JLVLKX007458
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 17:31:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JLVLmF066182
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:31:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JLVLAc025674
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:31:21 -0600
Date: Fri, 19 Oct 2007 16:31:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20071019163119.62eec6f0@weaponx.rchland.ibm.com>
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

Please pull from

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24

to pick up a handful of fixes for 4xx.  These are mostly to enable the
ibm_newemac driver for the various boards.  Since a few patches to the
driver are needed from Linus' tree, the branch is based off of his
latest tree as of this morning.

josh

Josh Boyer (4):
      [POWERPC] 4xx: Enable EMAC on the PPC 440GP Ebony board
      [POWERPC] 4xx: Fix timebase clock selection on Walnut
      [POWERPC] 4xx: Enable EMAC for PPC405 Walnut board
      [POWERPC] 4xx: Enable EMAC on Bamboo board

Valentine Barshak (3):
      [POWERPC] 4xx: Add RGMII support for Sequoia 440EPx
      [POWERPC] 4xx: Enable NEW EMAC support for Sequoia 440EPx.
      [POWERPC] 4xx: Split early debug output and early boot console for 44x
