Message-ID: <011101c402dc$77b09b60$3000a8c0@foundation>
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <40485490.8040207@246tNt.com>
Subject: Kernel startup assumptions/requirements
Date: Fri, 5 Mar 2004 12:05:39 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am new to Linux and am in the process of trying to get a kernel booted on
a PPC board.  What assumptions/requirements (if any) does the kernel have
about any system state/setup prior to the execution of the kernel entry
point?

Is it simply that the kernel is loaded and memory is accessible?   MMU
on/off?  Do any other peripherals (e.g 10ms timer) need to be initialized?

Thanks,
Stuart Yoder


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
