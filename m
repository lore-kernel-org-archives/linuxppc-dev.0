Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 305DADDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:00:43 +1000 (EST)
Date: Tue, 4 Sep 2007 21:07:33 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <20070905020733.GA25900@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,                                                                                                                 
                                                                                                                      
Please pull from 'for-2.6.24' branch of                                                                               
                                                                                                                      
        master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.24                                      
                                                                                                                      
to receive the following updates: 

 arch/powerpc/kernel/sysfs.c            |   60 +++++++++++++++++
 arch/powerpc/platforms/pasemi/idle.c   |    8 ++
 arch/powerpc/platforms/pasemi/pasemi.h |    4 -
 arch/powerpc/platforms/pasemi/pci.c    |   71 ++++++++++++++++++++
 arch/powerpc/platforms/pasemi/setup.c  |  112 +++++++++++++++++++++++++++++++--
 include/asm-powerpc/reg.h              |   48 ++++++++++----
 6 files changed, 281 insertions(+), 22 deletions(-)


Olof Johansson (5):
      [POWERPC] pasemi: add pasemi_pci_getcfgaddr()
      [POWERPC] pasemi: Add workaround for erratum 5945
      [POWERPC] pasemi: Export more SPRs to sysfs when CONFIG_DEBUG_KERNEL=y
      [POWERPC] pasemi: Print more information at machine check
      [POWERPC] pasemi: Move pasemi_idle_init() to late_initcall()


Patches also posted as replies to this email for general info.


Thanks,

Olof
