Message-ID: <3798D2F8.1F6A25D8@openbits.net>
Date: Fri, 23 Jul 1999 13:39:20 -0700
From: "Todd C. Larsen" <tlarsen@openbits.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Debugging an MPC8xx Linux kernel with GDB
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there a port of the gdb target monitor for the MPC8xx
family of embedded PowerPC processors?  Has anyone tried
to debug a Linux kernel built for these processors with
the serial port-to-gdb monitor configuration, or is there
some other approach?

I've got the x86 Linux-hosted cross compiler and binutils
build that target the PowerPC.  I'm just trying to get
the rest of the pieces together to do kernel device
driver debugging on an MPC860T target.

Thanks.

--
Todd C. Larsen
tlarsen@openbits.net

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
