Subject: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1074025766.23751.2.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 14:29:27 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a problem with the kernel build. It seems completely random in
occurrence, however I'm sure something has to be causing it.The error is
as follows:

cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory

And the kernel build can not complete. Sometimes running a make dep and
continuing again with a make uImage will correct the problem but not
always. Does anyone have any idea why sometimes this file does not get
built correctly and other times it does?

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
