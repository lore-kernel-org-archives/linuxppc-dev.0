Date: Tue, 30 Nov 1999 21:36:39 -0500 (EST)
From: Jon Howell <jonh@cs.dartmouth.edu>
To: Paul DuBois <dubois@primate.wisc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: installer default inode count
In-Reply-To: <19991130202147.20629@primate.wisc.edu>
Message-ID: <Pine.GSO.3.96.991130213026.24254C-100000@sitka.cs.dartmouth.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This happened to me a couple of weeks ago, and the problem went away
> when I reduced the size of the affected partition to be less than 2GB.
Ah hah. Well, I know I can fix the problem by starting over*, but I'll
mke2fs the disk by hand, which should set the inode ratio at '-i 4096'.
I'll use tune2fs to check it before I install, to determine whether it's
a bug in mke2fs, or whether the linuxppc installer is "helping out" with the
inode count. (Hollis hinted in an emailed reply that it is a known bug in
the installer.)

By the way, kudos to the linuxppc development folks. I have been out
of linuxppc land for a while, and recently reinstalled afresh.
It has come a long way! It's a very pleasant setup.

	--Jon

* At this point, I don't have much user data, so a reinstall is easier than
a backup/restore of all the system files.

 Jon Howell  jonh@cs.dartmouth.edu     finger jonh@cs.dartmouth.edu | pgp -kaf
 http://www.cs.dartmouth.edu/~jonh     170AE827  ADAB6559  9C2E3DB3  37BD72EC


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
