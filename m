Message-Id: <199910291305.JAA24820@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Kernel space question?
Date: Fri, 29 Oct 1999 09:05:25 -0400
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a quick question... When I was working to get Linux running on a custom
MPC860, it was necessary to move the IMMR to 0xF??????? in order to avoid a
kernel panic after the VM was running.  I understand the kernel has a
certain range of memory which is kernel space when the IMMR was at a lower
address it could not be directly accessed.  Could someone explain to me the
exact size of kernel space and what the valid range of addresses can be
accessed outside it?

Thanks in advance,
Jason

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
