Date: Sat, 24 May 2003 22:12:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: akuster@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: GPL inconsistency in arch/ppc/ocp/xlinx/
Message-ID: <20030524201213.GA8256@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Armin,

you seem to have added the the directory in the topic to the LinuxPPC
trees.  Unfortunately they have a license consitency that basically
makes them illegal to distribute, they claim to be under GPL but have
the following notice:

*     Xilinx products are not intended for use in life support appliances,
*     devices, or systems. Use in such applications are expressly prohibited.

Could you please contact Xilinc to clarify the license and/or remove
those files from the tree?  Thanks.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
