Message-Id: <199906261814.DAA03596@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Sun, 27 Jun 1999 03:14:30 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: [Q] PowerStack installimage
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

Now I make kernel and bootimages for R5.
I compiled kernel-2.2.1 with prep_fb.patch, and 
I would like to add zImage to "Linux1999installer.bin" as a 
"ramdisk.image.gz".

I make installer without fb_patch, error occurs when booting visual 
installer, with framebuffer errors. 
But, with fb_patch, another error, likes "ramdisk is not proper image",
occurs when change from zImage to visual installer.

I have to change libraries or compilers? 
Or I should use more newer kernels? If so, how to patch framebuffers?

I would so appreciate if you take me some ideas.

I use these sources:
 linux-2.2.1
 prep_fb.patch
 Linux1999.installer.bin (Rename to "ramdisk.image.gz")

Environment:
PowerStack MT
LinuxPPC R4 pure install environment.


Thanks.
----------------------
Kaz Aoshima = PReP station
Material deveropment, Faculty of engineering, 
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I am appreciate if you could tell me suggestions
 for my bad English expressions.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
