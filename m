Message-Id: <m1357B4-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Missing cpm_install_handler/cpm_free_handler on the MPC8260 port
To: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com
Date: Thu, 22 Jun 2000 09:37:54 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	When Linux version 2.4.0-test1-ac21 is compiled for a MPC8260,
	the cpm helper routines like cpm_install_handler and symbol
	cpm_free_handler are no longer available.  These routines are
	defined in arch/ppc/8xx_io/commproc.c, but none of the files in
	this directory get compiled into the kernel for a MPC8260 target.

	It appears that the interrupt controller on the MPC8260 is a bit
	different from the MPC8xx.  Has anyone ported the following
	routines or functionality from 8xx to 8260?

        cpm_interrupt_init
        cpm_install_handler
	cpm_free_handler

	If not, then I will work on adding this functionality.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
