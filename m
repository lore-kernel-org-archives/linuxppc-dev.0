From: jonb@marel.is
Subject: Problem with shared libraries in HHL with initrd
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF2290EC0A.032808E8-ON00256970.004061A5@marel.is>
Date: Fri, 6 Oct 2000 12:12:36 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am using Hard Hat Linux 1.2 with a custom MPC823 board and I am trying to
create a minimal initial ram disk, so the board can boot without having an
NFS root file system.  I am having a problem because shared libraries are
not being found.  For example init reports:

  init: error in loading shared libraries: libc.so.6: cannot open shared
object file: No such file or directory

My minimal file system has the following directories: /bin, /dev and /lib .
I put the shared libs
in the /lib directory.  In /bin I have init, sh and ls, copied from
/opt/hardhat/devkit/ppc/8xx/target/bin.

I seems the system expects to find the shared libraries in some other
directory than /lib.

I saw some discussion on the list about some symbolic links being required
to get this
working, but I have tried everything I can think of.

Everything is fine if I use staticly linked binaries.

Can anyone give me directions ?
Does someone have a "minroot.tar.gz" made with HHL 1.2 ?


Regards,

Jon Benediktsson
Marel hf.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
