Date: Sat, 15 May 1999 13:00:44 -0500 (CDT)
From: nathan ingersoll <ningerso@d.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ide-pmac
Message-ID: <Pine.SO4.4.02.9905151250240.6513-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think I found a problem with the cvs kernel. The function
pmac_ide_init_hwif_ports used to be passed a variable called base (as of
2.2.9) the 2.3.1 kernel's version does not get passed this parameter, but
it still references the variable.

If I'm reading it right, the line
	unsigned long base;
needs to be moved from pmac_ide_probe to the top and declared as global to
the file. Making this change has allowed me to get a little further in
compiling a new kernel.

Is there any reason not to do this? I'm not an experienced kernel
developer, so please put me in my place if I'm off base here. ;-)

Thanks,

Nathan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
