Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b4a419989df1@[129.116.196.236]>
Date: Thu, 13 Jan 2000 18:32:34 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: CodeWarrior objects -> LinuxPPC
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is it possible compile C source in CodeWarrior and create an object (or
library) that can be used under LinuxPPC?

For example, you should be able to take a really simple program, like:

#include <stdio.h>
void goo(float f)
{ printf("goo: f = %g\n", f); }

make an object in CW, copy to LinuxPPC, link it with gcc into some app that
can call goo.

(Why? CW has an AltiVec compiler, Linux currently has none.)

I notice that a CW "Shared Library" is recognized by /usr/bin/file as
"header for PowerPC PEF executable", but objdump will have nothing to do
with it.

My initial guess is "not yet".  Has anyone else ever tried this?

I guess there's no reason that objcopy couldn't be extended to handle this
(assuming CodeWarrior's object/lib file formats are public info).

Thanks,
-Greg
--------------------------------------------------------------------
|  Gregory E. Allen, Research Engineer  <gallen@arlut.utexas.edu>  |
|   Advanced Technology Laboratory, Sonar Development Division     |
| Applied Research Laboratories: The University of Texas at Austin |
--------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
