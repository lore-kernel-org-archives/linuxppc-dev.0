Message-Id: <199907112116.QAA23835@www2.tuckeris.com>
Date: Sun, 11 Jul 1999 16:03:54 -0500
Subject: Netbooting Linux on an iMac
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all:

Has anyone gotten LinuxPPC to net-boot using OF?  It doesn't look as if this
should be a big deal if we know the format that OF expects the kernel boot
image to be in.  A compiled-in ramdisk with the root filesystem that
contains enough data to mount other NFS filesystems (like /usr, /home, /etc,
etc...) should be enough to handle the diskless nature of things, right?

I suppose one other issue that would need to be dealt with would be creating
separate /etc, /var, /tmp, and /usr/local filesystems for each machine and
then making sure that the kernel mounts the right one...but this doesn't
seems to be insurmountable either.  The machine could be identified using
kernel args passed from firmware which is then used by scripts to mount the
right system.

That way, a simple utility could be created that involves booting off of a
CD (maybe into the MacOS since Linux can do that yet) and running a utility
where you identify the machine.  The utility would then configure OF to
netboot and pass the appropriate kernel args.  Talk about easy
configuration...

Forgive my creative rant here but to facilitate faster development times, I
intend to make the kernel I am developing for my company here netboot, so if
I can figure it out for that, then I think it would be just be a short step
to accomplishing the above under Linux as well...

-Charles

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
