Message-ID: <399B9874.99CF5C1C@mtjones.com>
Date: Thu, 17 Aug 2000 01:47:00 -0600
From: "M. Tim Jones" <mtj@mtjones.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Doc/Serial problems in HHL 1.2?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I've just installed the HHL 1.2 CD and I've run into a couple of
problems.

After installing the 1.2 CD, the 'make' would not work without studying
the Makefile and then adding a couple of files (.hhl_target_cpu and
.hhl_cross_compile).  After putting these in, the compile began but then
failed at math-emu (it no longer exists in the 1.2 subdirectory tree).
Are the .hhl* files created automatically somewhere?  Upon removing the
Math Emulation configuration item, the build continued.

Finally, the kernel built for the 860CLLF consistently results in a Bad
Trap in my_console_write.  It appears that the uart.c file (where
my_console_write resides) has undergone major surgery.

Any idea what's up?

Thanks,

Tim.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
