Message-ID: <36F69C36.9D5373CE@business.wm.edu>
Date: Mon, 22 Mar 1999 14:38:30 -0500
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: smbfs and smbmount and Paul's 2.2.1 kernel
References: <199903182331.KAA23199@tango.anu.edu.au>
	 <19990319001614.001351@mail.mipsys.com>
	 <19990319001614.001351@mail.mipsys.com> <4.2.0.25.19990322185247.036b2990@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In order to prove the Linuxppc port of the JDK is correct I need to mount NT
filesystems on my LinuxPPC system using smbmount and smbumount which are part of
the smbfs rpm (Sun's JDK on an NT box provides a reference system to run the JCK
against).

To make smbfs work (I grabbed the src rpm and built it) I need to compile SMB
_FS into the kernel.  I grabbed Paul's latest kernel source and dot.config file
and noticed there was no support for SMB included in his kernel by default.

Before I go and roll my own, has anyone played with mounting NT filesystems
using smbmount and smbumount commands?  Is this stable on linuxppc?  Are there
any gotchas I should look out for with this filesystem?

Thanks,

Kevin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
