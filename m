Message-ID: <BFC0587634C3D111AACB00805FA766FA0123B86B@exchny12.ny.smb.com>
From: "Velasquez, Carlos" <cv49989@imcnam.sbi.com>
To: "'Packer, Dave'" <dPacker@uppercase.xerox.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Umax S900 CD Rom problems...
Date: Fri, 21 May 1999 14:42:10 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave,

Thanks for the help. I am running Mac OS 8.1 and using the BootX utility.
Out of curiousity, is there a difference whether I run 8.1 or 8.5? (If so, I
will load upgrade to 8.5, I have the disk but wasn't sure if it was fully
compatible with clones.)

I will try passing the arg video='tt128fb'. Your suspicions were correct, I
am trying to go with the Pre-R5 version. I will try 4.1 then try moving up
to Pre-R5 instead. Someone else also suggested that I try YellowDog Linux's
ramdisk.gz file (it is supposed to have an improvement in the installer for
the CD method.)

Will keep y'all posted!

Carlos

______________________________________________________________________
C.F. Velasquez
Asst. Vice President
Global Database and Technology Division
Salomon Smith Barney, Inc.

> -----Original Message-----
> From:	Packer, Dave [SMTP:dPacker@uppercase.xerox.com]
> Sent:	Friday, May 21, 1999 2:03 PM
> To:	'linuxppc-dev@lists.linuxppc.org'
> Subject:	Umax S900 CD Rom problems...
> 
> 
> 
> Carlos - 
> 
> I have a UMAX S900/200 with the Matsashita drive.  I've been able to
> install
> without any problems.  What
> OS are you running? I'm running 8.5.1.  I've installed 4.1 and now am
> running Pre-R5, except for some very small FBDev problems I'm perfectly
> satisfied with what I have.  Are you installing with BootX? make sure you
> de-select no-video-driver and you can pass the arg of video='tt128fb' to
> the
> kernel.  
> 
> Other Notes:
> 
> Don't run the installer from a HFS+ partition
> I've had the best success by dragging the RedHat onto an non-HFS+
> partition
> and installing from there
> 
> If you are shooting for Pre-R5: I know that about a week ago I thought I
> might try re-installing and had some problems with the recent
> redhat.ramdisk.gz where it couldn't recognize any of my drives.  That
> might
> be where your problem is.  Can't help you there though probably have to
> wait
> until R5 comes out sometime in the next week or so.
> 
> Dave-
> 
> 
> 
> [[ This message was sent via the linuxppc-dev mailing list.  Replies are
> ]]
> [[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your
> ]]
> [[ reply is of general interest. Please check http://lists.linuxppc.org/
> ]]
> [[ and http://www.linuxppc.org/ for useful information before posting.
> ]]

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
