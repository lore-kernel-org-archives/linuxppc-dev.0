Message-ID: <371A7FAF.871D2E9C@dgs.monash.edu.au>
Date: Mon, 19 Apr 1999 00:58:24 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>
Subject: Embedded LinuxPPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I donwloaded the linux source (embedded-2.2.5.tgz) from
www.ppc.kernel.org from the embedded directory.  It has support for the
MBX but not for the ADS.  I know of people (Magnus Damm) who have had it
running on the ADS/FADS but it looks like it is not part of the official
source tree.

I couldn't get a kernel to compile for MBX.  It's having problems with
the pic8259 (can't remember the exact number).  I haven't looked into
this deeply yet so it is not worrying me much at this stage.  Will the
sources compile for an ADS board if I change the CONFIG_MBX to
CONFIG_FADS in the .config file ?  Or does the make config command
create other files in subdirectories ?

Will the the ADS/FADS be part of the official LinuxPPC source tree ?

Are there patches for the ADS/FADS against a specific source tree
version ?

Who is the official maintainer (or maintainers) for the embedded PPC
systems ?  ie. who puts the files in the embedded directory on the FTP
site ?

I have a custom mpc860 board which has a console on SMC1 and ethernet on
SCC4.  Is there a HOWTO or README on how to implement a new target board
?  What about common code accross a processor type or processor family.
I'm not that familiar with the Linux source tree at the moment, so I'd
like to get the right advice so I don't stuff things up.

Thanks,
Brendan Simon.

PS. At this stage I just want to get a kernel compiled to run on an ADS
board.  All I really need is console support on SMC1, ethernet support
on SCC1, TCP/IP, NFS.  I'd like to be able to mount my root filesystem
via NFS for development so I don't have to keep programming the Flash.
As I understand it the kernel is capable of doing this so I should only
need to program the flash with the compiled kernel.  Is that correct ?

Ta :)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
