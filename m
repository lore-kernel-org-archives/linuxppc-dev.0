Message-Id: <m132D91-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: MontaVista 7xx toolchain can produce code for MPC8260
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 14 Jun 2000 09:23:47 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Recently, I have struggling with how to compile/link
	applications for the MPC8260 with hard floating point.  I am
	able to statically link applications from an iMac running
	Yellow Dog Linux Champion Server version 1.2, and have them to
	run on the EST SBC8260.

	The MontaVista (http://www.mvista.com/) 7xx toolchain produces
	hard floating point, and this code will run on the MPC8260.  The
	MontaVista 7xx toolchain can be obtained from:

	ftp://ftp.mvista.com/pub/CDK/wip/common/RPMS
	ftp://ftp.mvista.com/pub/CDK/wip/ppc_7xx/RPMS/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
