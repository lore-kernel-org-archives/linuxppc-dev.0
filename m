Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <78197CD6-7F72-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@lists.linuxppc.org
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: OpenPIC and the 2.6 kernel
Date: Fri, 26 Mar 2004 17:11:02 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am working on upgrading a board support package from the 2.4.25
kernel to the 2.6.5, and I noticed that it looks like the OpenPIC
support has taken a step BACK in the 2.6 kernel.

In the 2.4 tree, openpic_hookup_cascade() exists, allowing non-8259
cascades to IRQs other than 0.  This seems to be totally missing from
the 2.6 kernel (82c59 is the ONLY supported cascade type there).  As my
board uses a custom PLD interrupt controller cascaded to an MPC107,
this is a problem.

Have I gotten the wrong repository for LinuxPPC 2.6?  I'm using
ppc.bkbits.net/linuxppc-2.5, which shows up as the 2.6.5-rc1 kernel.
If not, is there a reason this feature is now missing for the OpenPIC
driver?

Thanks,
John Whitney


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
