From: Arturo Nunez <artnpp@cs.ucf.edu>
Message-Id: <200103171623.LAA21811@iris.cs.ucf.edu>
Subject: Setting 2 ports in 860T
To: linuxppc-embedded@lists.linuxppc.org (linuxppc-embedded)
Date: Sat, 17 Mar 2001 11:23:49 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
	As a newby had some problems compiling the kernel, but finally I could
	do that.
	Now my system is a :
	-RPX CLLF
	-CPU=XPC860TZP50B5

	I have compiled the kernel 2.4 from bitkeeper.
	Basically doing :
	-	make rpxcllf_config
	Now when I boot the board with the new kernell, even it recognizes both
	ports,10 and 100 Mbits, as eth0 and eth1, I cant work with the 100
	port.
	The 10 port gets and Ip using dhcpd
	I manually give and IP to the 100 port.
	But when I disconnect the cable from the 100 port, as a test, the 10
	port answers.
	So it seems to be that the 100 port haven been totally configured.

	Any Suggestion will be appreciate.

	Regards

	Arturo Nunez


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
