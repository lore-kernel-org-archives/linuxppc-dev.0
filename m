Message-ID: <371CC261.AF18E73A@ibm.net>
Date: Tue, 20 Apr 1999 18:07:30 +0000
From: "J. Robokos" <roboj@ibm.net>
MIME-Version: 1.0
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.2.6-ac1 problem
References: <Pine.LNX.3.96.990420102601.23151G-100000@globegate.utm.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood wrote:

> On Mon, 19 Apr 1999, root wrote:
>
> > I compiled the latest kernel from source and I created vmlinux with no
> > problems.  After installing it in my system folder on my mac partition
> > and booting linux again, I get I/O errors somewhat randomly.
> > The message that is displayed is "No space left on device".  The file
> > /var/log/messages conatins the following lines:
> >
> > Apr 19 23:23:07 localhost kernel: EXT2-fs error (device ide0(3,4)):
> > ext2_new_block: Free blocks count corrupted for block group 13
>
> We've had similar problems with free block corruption under MkLinux
> (2.0.37).  This may be a red herring, but I've only noticed the damage on
> the last partition mounted.  You might try mounting a bogus partition
> after the others and see if it goes away.  Just a wild thought.  Anyway,
> the problem began when someone ported some changes from the current
> development sources into the 2.0.xx tree, between 2.0.33 and 2.0.36 (the
> former was fine, the latter has the problem.  It might be easier to find
> in the context of 2.0.xx since many less things were changing....
>
> Later,
> David
>
> David A. Gatwood                         Visit globegate's internet
> dgatwood@globegate.utm.edu                  talker, Deep Space 36
> http://globegate.utm.edu                telnet globegate.utm.edu:9624

I don't think the error is happening on my last partition.  To verify that,
I tried compiling a c program and I got an error (after a few tries) saying
that ld failed writing to /tmp
The last few partitions of my hard drive are listed below:

...
 7:       Apple_UNIX_SVR2 opt                     614400 @ 1823921  (300.0M)

 8:       Apple_UNIX_SVR2 home                    102400 @ 2438321  ( 50.0M)

 9:             Apple_HFS MacOS                 11527935 @ 2540721  (  5.5G)

and the dirctory /tmp is on another partition on the same drive.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
