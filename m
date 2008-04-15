Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25B06DE2A0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:21 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 00/13 v4] [POWERPC] ppc32 mm init clean and 85xx kernel reloc
Date: Tue, 15 Apr 2008 14:52:18 -0500
Message-Id: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed EXPORT_SYMBOL of memstart_addr
* Fixed phys_addr_t typedef so its not exported to user space
* Added new patch that splits out removal of KERNEL_PGD_PTRS & USER_PGD_PTRS
  and cleaning up pmd_page macro

These patches exist in the following git tree:

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git ppc32_mm_init

Paul, can you please apply patches 01-12 to your powerpc-next tree.  We can than
further discuss the last patch and any changes you'd like to see.

- k
