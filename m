From: Arturo Nunez <artnpp@cs.ucf.edu>
Message-Id: <200103161804.NAA21697@iris.cs.ucf.edu>
Subject: Problems Compiling 2_4 for 860
To: linuxppc-embedded@lists.linuxppc.org (ppc)
Date: Fri, 16 Mar 2001 13:04:19 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
	I have been compiling using the MVISTA tools the kernel 2_4 from
	bitkeeper.
	The CPU is = XPC860TZP50B5
	I have follow the following Steps.
	-	make mrproper
	-	make rpxcllf_config
	-	make oldconfig
	-	make dep zImage

	Finally I may compile the zImage, but when I try to load from the
	Board, doesnt Recognize the file, the message is :

		load_tftp(): ** E_RPX_NOT_SREC
	What should be error ??
	Regards

	Arturo Nunez

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
