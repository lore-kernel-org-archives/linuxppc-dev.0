Message-Id: <199907141454.XAA27695@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Wed, 14 Jul 1999 23:55:18 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: X runs on PReP with FBpatch. But......
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I run XF86_FBdev with linux-2.2.10 with Jeff Rugen's 
prep_fb.patch.
Thanks for cool framebuffer patch for PowerStack.
Now I only tested with new zImage boot, and test mode 
on Xconfigurator.
Maybe That's sounds good.
I found a "penguin" on boot sequence.

Works:
1.Manual frame_buffer patch for kernel.
  The patch is made for kernel-2.2.1, so it cannot add 
  patches automatically on 2.2.10 kernel source.
2.Compile kernel with framebuffer option.
3.Install it.
4.Reboot.
5.Install XFree86-FBdev.rpm on R5 CD-ROM.
6.Run Xconfigurator
7.It would detect CLgen, so push "OK".
8.Set color modes and monitor modes.
  I set custom, and 1024x768 with 8bit and 16bit mode, 
  with 1024x768 Hireflesh mode.
9.Test mode start. If change monirtor modes for Xwindow like,
  Push OK.

I don't know after No.9, because SCSI control.drops down and freeze
my machine.
#On R5, SCSI is easily drops down on my machine.
But maybe a purpose for Framebuffer X.

But, I would like to run Xbh.
I could not run Xbh on my R5 environment before.
How would I do to run Xbh? Were ther any patches?

Best regards.
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
