Message-Id: <AF223B12F1FDD2119253006097C4FCEC05B138@cats.pdri.xerox.com>
From: "Packer, Dave" <dPacker@uppercase.xerox.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Umax S900 CD Rom problems...
Date: Fri, 21 May 1999 11:02:32 -0700
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Carlos - 

I have a UMAX S900/200 with the Matsashita drive.  I've been able to install
without any problems.  What
OS are you running? I'm running 8.5.1.  I've installed 4.1 and now am
running Pre-R5, except for some very small FBDev problems I'm perfectly
satisfied with what I have.  Are you installing with BootX? make sure you
de-select no-video-driver and you can pass the arg of video='tt128fb' to the
kernel.  

Other Notes:

Don't run the installer from a HFS+ partition
I've had the best success by dragging the RedHat onto an non-HFS+ partition
and installing from there

If you are shooting for Pre-R5: I know that about a week ago I thought I
might try re-installing and had some problems with the recent
redhat.ramdisk.gz where it couldn't recognize any of my drives.  That might
be where your problem is.  Can't help you there though probably have to wait
until R5 comes out sometime in the next week or so.

Dave-



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
