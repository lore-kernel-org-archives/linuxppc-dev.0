From: mikep@ugcs.caltech.edu (Michael Pruett)
Message-Id: <199907080424.VAA09099@myxo.ugcs.caltech.edu>
Subject: Bugs I've encountered in Linux/PPC R5.
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 7 Jul 1999 21:24:45 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was really enthused to install LinuxPPC on my Power Mac 8500.  My
enthusiasm has been since slightly diminished by a host of problems I
encountered with the system, but I'd like to help make LinuxPPC as
robust as possible.

1) The first thing I encountered was that the X installer froze while
formatting and mounting my hard drive since it was connected to the
internal MESH controller.  I got MESH timeouts and SCSI bus resets
forever until I rebooted the machine.  I solved this problem by
connecting my internal SCSI chain to the slow SCSI bus.

Is this MESH timeout problem caused by poor termination or some other
kind of hardware failure, or is the driver broken?  Many people are
running into this problem.  If it's a software problem, is someone
working on a fix?  If it's a hardware problem, would it be possible to
say something about it on the web site or in the online installation
guide?

2) One very minor problem I ran into was that upon logging into Gnome,
I saw files with names like "??!?" in my home directory.  One was
created every time I logged in.  This is just an inconvenience.  Is
this a known bug?

3) Finally after rebooting a few times, I ran into a problem with the
initialization scripts running fsck on my root partition which was
already mounted read/write.  This situation caused fsck to report an
error and I was given the option of "repairing" my disk or shutting
down.  This seems like it should be a very simple thing to fix.  I
won't bother if someone's already fixed it though.

Michael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
