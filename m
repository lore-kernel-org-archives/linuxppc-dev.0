Message-Id: <199905061917.MAA10016@soda.CSUA.Berkeley.EDU>
To: Brad Boyer <flar@cegt201.bradley.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC 
In-Reply-To: Your message of "Wed, 05 May 1999 22:29:23 CDT."
             <199905060329.WAA28970@cegt201.bradley.edu>
Date: Thu, 06 May 1999 12:17:39 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



 
> Do you always use BootX?  I've never even tried it...

I normally start Linux using BootX from within MacOS. For some reason
this seems to work better than using OF to boot. My guess is that the
nPower init or the MacOS init sets up the SMP card correctly.

The downside to this is that you need a MacOS partition. The upside
for me is that I finally found something to do with my old 250 MB hard
drive.
 
> Thanks.  If you have any modules, could you include them too?  I'd
> appreciate it.

Try to download on of the images from the URL:

http://www.CSUA.Berkeley.EDU/~ranga/downloads/linuxPPC/kernels/

All of the images are the same. You should plain vmlinux, a gzip'ed
version and a sit.hqx version. As a warning, I will probably get rid
of the vmlinux image sometime next week since it is so large.

I don't have any modules, *almost* everything is compiled into the
kernel.

HTH,

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
