Message-ID: <371CEE40.4711C164@ibm.net>
Date: Tue, 20 Apr 1999 21:14:40 +0000
From: "J. Robokos" <roboj@ibm.net>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.2.6-ac1 problem
References: <4.2.0.32.19990420113648.044b7ea0@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> At 01:33 20.04.99 , root wrote:
>
> >I compiled the latest kernel from source and I created vmlinux with no
> >problems.  After installing it in my system folder on my mac partition
> >and booting linux again, I get I/O errors somewhat randomly.
> >The message that is displayed is "No space left on device".  The file
> >/var/log/messages conatins the following lines:
> >
> >Apr 19 23:23:07 localhost kernel: EXT2-fs error (device ide0(3,4)):
> >ext2_new_block: Free blocks count corrupted for block group 13
>
> Are you sure you use egcs-1.1.2 for compiling the kernel? egcs versions
> before 1.1 (or 1.1.1? I don't remember anymore) had this problem.
>
> Franz.

I re-compiled with Gary Thomas' egcs RPMS's and so far it seems the
problem no longer exists.  Thanks for the help.

-J. Robokos


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
