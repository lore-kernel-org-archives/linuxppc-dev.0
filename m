Message-Id: <m131qWd-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: init is running (didn't trigger the wait queue panic)
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 13 Jun 2000 09:14:38 -0400 (EDT)
Cc: all@cideas.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	* To: linuxppc-embedded@lists.linuxppc.org

	I tried running init again with Linux 2.4.0-test1-ac10
	(through changeset 1.247.1.6 00/06/12 18:04:09-04:00
	dmalek@geefour.netx4.com), and I was surprised to find that it
	worked.  Previously, init was triggering a wait queue panic in the
	scheduler.

	With init active, inetd is running and it is possible to use
	telnet to establish a connection.  cool very cool :)

	Target: EST SBC8260 with MPC8260 Rev A.1 at CPU/CPM/BUS 200/167/66

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
